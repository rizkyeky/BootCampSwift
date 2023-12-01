//
//  BarcodeScannerViewController.swift
//  barcode_scan
//
//  Created by Julian Finkler on 20.02.20.
//

import UIKit
import MTBBarcodeScanner

protocol BarcodeScannerViewControllerDelegate {
    func didScanBarcodeWithResult(_ controller: BarcodeScannerViewController?, scanResult: ScanResult)
    func didFailWithErrorCode(_ controller: BarcodeScannerViewController?, errorCode: String)
}

class BarcodeScannerViewController: UIViewController {
    private var previewView: UIView?
    private var scanRect: ScannerOverlay?
    private var scanner: MTBBarcodeScanner?
    
    var config: Configuration = Configuration.with {
        $0.strings = [
            "cancel" : "Cancel",
            "flash_on" : "Flash on",
            "flash_off" : "Flash off",
        ]
        $0.useCamera = -1 // Default camera
        $0.autoEnableFlash = false
    }
    
    private let formatMap = [
        BarcodeFormat.aztec : AVMetadataObject.ObjectType.aztec,
        BarcodeFormat.code39 : AVMetadataObject.ObjectType.code39,
        BarcodeFormat.code93 : AVMetadataObject.ObjectType.code93,
        BarcodeFormat.code128 : AVMetadataObject.ObjectType.code128,
        BarcodeFormat.dataMatrix : AVMetadataObject.ObjectType.dataMatrix,
        BarcodeFormat.ean8 : AVMetadataObject.ObjectType.ean8,
        BarcodeFormat.ean13 : AVMetadataObject.ObjectType.ean13,
        BarcodeFormat.interleaved2Of5 : AVMetadataObject.ObjectType.interleaved2of5,
        BarcodeFormat.pdf417 : AVMetadataObject.ObjectType.pdf417,
        BarcodeFormat.qr : AVMetadataObject.ObjectType.qr,
        BarcodeFormat.upce : AVMetadataObject.ObjectType.upce,
    ]
    
    var delegate: BarcodeScannerViewControllerDelegate?
    
    private var device: AVCaptureDevice? {
        return AVCaptureDevice.default(for: .video)
    }
    
    private var isFlashOn: Bool {
        return device != nil && (device?.flashMode == AVCaptureDevice.FlashMode.on || device?.torchMode == .on)
    }
    
    private var hasTorch: Bool {
        return device?.hasTorch ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        
#if targetEnvironment(simulator)
        view.backgroundColor = .lightGray
#endif
        
        previewView = UIView(frame: view.bounds)
        if let previewView = previewView {
            previewView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(previewView)
        }
        setupScanRect(view.bounds)
        
        let restrictedBarcodeTypes = mapRestrictedBarcodeTypes()
        if restrictedBarcodeTypes.isEmpty {
            scanner = MTBBarcodeScanner(previewView: previewView)
        } else {
            scanner = MTBBarcodeScanner(metadataObjectTypes: restrictedBarcodeTypes,
                                        previewView: previewView
            )
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: config.strings["cancel"],
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancel)
        )
        updateToggleFlashButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if scanner!.isScanning() {
            scanner!.stopScanning()
        }
        
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        
        scanRect?.startAnimating()
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                self.startScan()
            } else {
#if !targetEnvironment(simulator)
                self.errorResult(errorCode: "PERMISSION_NOT_GRANTED")
#endif
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scanner?.stopScanning()
        scanRect?.stopAnimating()
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        if isFlashOn {
            setFlashState(false)
        }
        
        super.viewWillDisappear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupScanRect(CGRect(origin: CGPoint(x: 0, y:0), size: size))
    }
    
    private func setupScanRect(_ bounds: CGRect) {
        if scanRect != nil {
            scanRect?.stopAnimating()
            scanRect?.removeFromSuperview()
        }
        scanRect = ScannerOverlay(frame: bounds)
        if let scanRect = scanRect {
            scanRect.translatesAutoresizingMaskIntoConstraints = false
            scanRect.backgroundColor = UIColor.clear
            view.addSubview(scanRect)
            scanRect.startAnimating()
        }
    }
    
    private func startScan() {
        do {
            try scanner!.startScanning(with: cameraFromConfig, resultBlock: { codes in
                if let code = codes?.first {
                    let codeType = self.formatMap.first(where: { $0.value == code.type });
                    let scanResult = ScanResult.with {
                        $0.type = .barcode
                        $0.rawContent = code.stringValue ?? ""
                        $0.format = codeType?.key ?? .unknown
                        $0.formatNote = codeType == nil ? code.type.rawValue : ""
                    }
                    self.scanner!.stopScanning()
                    self.scanResult(scanResult)
                }
            })
            if(config.autoEnableFlash){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.setFlashState(true)
                }
            }
        } catch {
            self.scanResult(ScanResult.with {
                $0.type = .error
                $0.rawContent = "\(error)"
                $0.format = .unknown
            })
        }
    }
    
    @objc private func cancel() {
        scanResult( ScanResult.with {
            $0.type = .cancelled
            $0.format = .unknown
        });
    }
    
    @objc private func onToggleFlash() {
        setFlashState(!isFlashOn)
    }
    
    private func updateToggleFlashButton() {
        if !hasTorch {
            return
        }
        
        let buttonText = isFlashOn ? config.strings["flash_off"] : config.strings["flash_on"]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonText,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onToggleFlash)
        )
    }
    
    private func setFlashState(_ on: Bool) {
        if let device = device {
            guard device.hasFlash && device.hasTorch else {
                return
            }
            
            do {
                try device.lockForConfiguration()
            } catch {
                return
            }
            
            device.flashMode = on ? .on : .off
            device.torchMode = on ? .on : .off
            
            device.unlockForConfiguration()
            updateToggleFlashButton()
        }
    }
    
    private func errorResult(errorCode: String){
        delegate?.didFailWithErrorCode(self, errorCode: errorCode)
        dismiss(animated: false)
    }
    
    private func scanResult(_ scanResult: ScanResult){
        dismiss(animated: true)
        self.delegate?.didScanBarcodeWithResult(self, scanResult: scanResult)
    }
    
    private func mapRestrictedBarcodeTypes() -> [String] {
        var types: [AVMetadataObject.ObjectType] = []
        
        config.restrictFormat.forEach({ format in
            if let mappedFormat = formatMap[format]{
                types.append(mappedFormat)
            }
        })
        
        return types.map({ t in t.rawValue})
    }
    
    private var cameraFromConfig: MTBCamera {
        return config.useCamera == 1 ? .front : .back
    }
}

class ScannerOverlay: UIView {
//    private let line: UIView = UIView()
    
    private var scanLineRect: CGRect {
        let scanRect = calculateScanRect()
        let positionY = scanRect.origin.y + (scanRect.size.height / 2)
        
        return CGRect(x: scanRect.origin.x,
                      y: positionY,
                      width: scanRect.size.width,
                      height: 1
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        line.backgroundColor = UIColor.red
//        line.translatesAutoresizingMaskIntoConstraints = false
        
//        addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let overlayColor = UIColor(red: 0.0,
                                   green: 0.0,
                                   blue: 0.0,
                                   alpha: 0.55
        )
        
        context?.setFillColor(overlayColor.cgColor)
        context?.fill(bounds)
        
        // make a hole for the scanner
        let holeRect = calculateScanRect()
        let holeRectIntersection = holeRect.intersection(rect)
        UIColor.clear.setFill()
        UIRectFill(holeRectIntersection)
        
        // draw a horizontal line over the middle
//        let lineRect = scanLineRect
//        line.frame = lineRect
        
        // draw the green corners
//        let cornerSize: CGFloat = 30
//        let path = UIBezierPath()
        
        //top left corner
//        path.move(to: CGPoint(x: holeRect.origin.x, y: holeRect.origin.y + cornerSize))
//        path.addLine(to: CGPoint(x: holeRect.origin.x, y: holeRect.origin.y))
//        path.addLine(to: CGPoint(x: holeRect.origin.x + cornerSize, y: holeRect.origin.y))
        
        //top right corner
//        let rightHoleX = holeRect.origin.x + holeRect.size.width
//        path.move(to: CGPoint(x: rightHoleX - cornerSize, y: holeRect.origin.y))
//        path.addLine(to: CGPoint(x: rightHoleX, y: holeRect.origin.y))
//        path.addLine(to: CGPoint(x: rightHoleX, y: holeRect.origin.y + cornerSize))
        
        // bottom right corner
//        let bottomHoleY = holeRect.origin.y + holeRect.size.height
//        path.move(to: CGPoint(x: rightHoleX, y: bottomHoleY - cornerSize))
//        path.addLine(to: CGPoint(x: rightHoleX, y: bottomHoleY))
//        path.addLine(to: CGPoint(x: rightHoleX - cornerSize, y: bottomHoleY))
        
        // bottom left corner
//        path.move(to: CGPoint(x: holeRect.origin.x + cornerSize, y: bottomHoleY))
//        path.addLine(to: CGPoint(x: holeRect.origin.x, y: bottomHoleY))
//        path.addLine(to: CGPoint(x: holeRect.origin.x, y: bottomHoleY - cornerSize))
        
//        path.lineWidth = 2
//        UIColor.green.setStroke()
//        path.stroke()
    }
    
    public func startAnimating() {
//        layer.removeAnimation(forKey: "flashAnimation")
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.fromValue = NSNumber(value: 0.0)
//        flash.toValue = NSNumber(value: 1.0)
//        flash.duration = 0.25
//        flash.autoreverses = true
//        flash.repeatCount = HUGE
//        line.layer.add(flash, forKey: "flashAnimation")
    }
    
    public func stopAnimating() {
        layer.removeAnimation(forKey: "flashAnimation")
    }
    
    private func calculateScanRect() -> CGRect {
        let rect = frame
        
        let frameWidth = rect.size.width
        var frameHeight = rect.size.height
        
        let isLandscape = frameWidth > frameHeight
        let widthOnPortrait = isLandscape ? frameHeight : frameWidth
        let scanRectWidth = widthOnPortrait * 0.8
        let aspectRatio: CGFloat = 1
        let scanRectHeight = scanRectWidth * aspectRatio
        
        if isLandscape {
            let navbarHeight: CGFloat = 32
            frameHeight += navbarHeight
        }
        
        let scanRectOriginX = (frameWidth - scanRectWidth) / 2
        let scanRectOriginY = (frameHeight - scanRectHeight) / 2
        return CGRect(x: scanRectOriginX,
                      y: scanRectOriginY,
                      width: scanRectWidth,
                      height: scanRectHeight
        )
    }
}
