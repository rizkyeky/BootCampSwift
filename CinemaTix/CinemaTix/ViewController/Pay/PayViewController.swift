//
//  BayarViewController.swift
//  CinemaTix
//
//  Created by Eky on 21/12/23.
//

import UIKit
import AVKit
import MLKitVision
import MLKitBarcodeScanning

class PayViewController: BaseViewController {
    
    let videoDataOutputQueueLabel = "com.google.mlkit.visiondetector.VideoDataOutputQueue"
    let sessionQueueLabel = "com.google.mlkit.visiondetector.SessionQueue"
    
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private lazy var captureSession = AVCaptureSession()
    private lazy var sessionQueue = DispatchQueue(label: sessionQueueLabel)
    private var lastFrame: CMSampleBuffer?
    private let scanner = BarcodeScanner.barcodeScanner(options: BarcodeScannerOptions(formats: .all))
    private var detectionSpeed: DetectionSpeed = DetectionSpeed.noDuplicates
    private var latestBuffer: CVImageBuffer!
    private var standardZoomFactor: CGFloat = 1
    private var nextScanTime = 0.0
    private var imagesCurrentlyBeingProcessed = false
    private var timeoutSeconds: Double = 0
    private var barcodesString: Array<String?>?
    
//    var result: ((Array<Barcode>?, Error?, UIImage) -> ())?
    
    private lazy var previewOverlayView: UIImageView = {
        precondition(isViewLoaded)
        let previewOverlayView = UIImageView(frame: .zero)
        previewOverlayView.contentMode = UIView.ContentMode.scaleAspectFill
        previewOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return previewOverlayView
    }()
    
    private lazy var annotationOverlayView: UIView = {
        precondition(isViewLoaded)
        let annotationOverlayView = UIView(frame: .zero)
        annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return annotationOverlayView
    }()
    
    let cameraView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first {
            
            view.addSubview(cameraView)
            cameraView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            setUpPreviewOverlayView()
            setUpAnnotationOverlayView()
            setUpCaptureSessionOutput()
            setUpCaptureSessionInput()
            startSession()
            
        } else {
            
            self.view.backgroundColor = .systemGroupedBackground
            let label = UILabel()
            let icon = UIImageView(image: UIImage(systemName: "camera.fill"))
            icon.tintColor = .label
            label.text = "No Camera"
            label.textAlignment = .center
            self.view.addSubview(label)
            self.view.addSubview(icon)
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            icon.snp.makeConstraints { make in
                make.height.equalTo(32)
                make.width.equalTo(40)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(label.snp.top).offset(-16)
            }
        }
    }
    
    override func setupNavBar() {
        navigationItem.title = "Scan QR Code"
    }
    
#if !targetEnvironment(simulator)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = cameraView.frame
    }
#endif
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSession()
    }
    
    private func startSession() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.startRunning()
        }
    }
    
    private func stopSession() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.stopRunning()
        }
    }
    
    private func setUpPreviewOverlayView() {
        cameraView.addSubview(previewOverlayView)
        previewOverlayView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(cameraView)
            make.left.right.equalTo(cameraView)
        }
    }
    
    private func setUpAnnotationOverlayView() {
        cameraView.addSubview(annotationOverlayView)
        annotationOverlayView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(cameraView)
        }
    }
    
    private func setUpCaptureSessionInput() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            let cameraPosition: AVCaptureDevice.Position = .back
            guard let device = strongSelf.captureDevice(forPosition: cameraPosition) else {
                print("Failed to get capture device for camera position: \(cameraPosition)")
                return
            }
            do {
                strongSelf.captureSession.beginConfiguration()
                let currentInputs = strongSelf.captureSession.inputs
                for input in currentInputs {
                    strongSelf.captureSession.removeInput(input)
                }
                
                let input = try AVCaptureDeviceInput(device: device)
                guard strongSelf.captureSession.canAddInput(input) else {
                    print("Failed to add capture session input.")
                    return
                }
                strongSelf.captureSession.addInput(input)
                strongSelf.captureSession.commitConfiguration()
            } catch {
                print("Failed to create capture device input: \(error.localizedDescription)")
            }
        }
    }
    
    private func setUpCaptureSessionOutput() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.beginConfiguration()
            strongSelf.captureSession.sessionPreset = AVCaptureSession.Preset.low
            
            let output = AVCaptureVideoDataOutput()
            output.videoSettings = [
                (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA
            ]
            output.alwaysDiscardsLateVideoFrames = true
            let outputQueue = DispatchQueue(label: self.videoDataOutputQueueLabel)
            output.setSampleBufferDelegate(strongSelf, queue: outputQueue)
            
            guard strongSelf.captureSession.canAddOutput(output) else {
                print("Failed to add capture session output.")
                return
            }
            strongSelf.captureSession.addOutput(output)
            strongSelf.captureSession.commitConfiguration()
        }
    }
    
    private func captureDevice(forPosition position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        if #available(iOS 10.0, *) {
            let discoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .unspecified
            )
            return discoverySession.devices.first { $0.position == position }
        }
        return nil
    }
}

extension PayViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to get image buffer from sample buffer.")
            return
        }
        
        latestBuffer = imageBuffer
        
        let currentTime = Date().timeIntervalSince1970
        let eligibleForScan = currentTime > nextScanTime && !imagesCurrentlyBeingProcessed
        
        if ((detectionSpeed == DetectionSpeed.normal || detectionSpeed == DetectionSpeed.noDuplicates) && eligibleForScan || detectionSpeed == DetectionSpeed.unrestricted) {
            
            nextScanTime = currentTime + timeoutSeconds
            imagesCurrentlyBeingProcessed = true
            
            let ciImage = latestBuffer.image
            
            let image = VisionImage(image: ciImage)
            image.orientation = imageOrientation(
                deviceOrientation: UIDevice.current.orientation,
                defaultOrientation: .portrait,
                position: AVCaptureDevice.Position.back
            )
            
            scanner.process(image) { [self] barcodes, error in 
                
                imagesCurrentlyBeingProcessed = false
                
                if (detectionSpeed == DetectionSpeed.noDuplicates) {
                    let newScannedBarcodes = barcodes?.compactMap({ barcode in
                        return barcode.rawValue
                    }).sorted()
                    if (error == nil && barcodesString != nil && newScannedBarcodes != nil && barcodesString!.elementsEqual(newScannedBarcodes!)) {
                        return
                    } else if (newScannedBarcodes?.isEmpty == false) {
                        barcodesString = newScannedBarcodes
                    }
                }
            }
            barcodesString?.forEach { str in
                print(str)
            }
        }
    }
    
    func imageOrientation(deviceOrientation: UIDeviceOrientation, defaultOrientation: UIDeviceOrientation, position: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
        switch deviceOrientation {
        case .portrait:
            return position == .front ? .leftMirrored : .right
        case .landscapeLeft:
            return position == .front ? .downMirrored : .up
        case .portraitUpsideDown:
            return position == .front ? .rightMirrored : .left
        case .landscapeRight:
            return position == .front ? .upMirrored : .down
        case .faceDown, .faceUp, .unknown:
            return .up
        @unknown default:
            return imageOrientation(deviceOrientation: defaultOrientation, defaultOrientation: .portrait, position: .back)
        }
    }
}
