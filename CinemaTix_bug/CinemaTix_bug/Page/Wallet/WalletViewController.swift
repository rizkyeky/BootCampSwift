//
//  WalletViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit
import UIKitLivePreview
import FloatingPanel
import KeyboardObserver
import RxSwift
import RxCocoa
import SPAlert
import CoreNFC

class WalletViewController: BaseViewController {

    @IBOutlet weak var base: UIView!
    @IBOutlet weak var card: Card!

    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var baseCanvas: UIView!
    
    @IBOutlet weak var transSection: TransSection!
    
    let amountText = UILabel()
    
    var floatingPanelController: FloatingPanelController!
    
    let keyboardObserver = KeyboardObserver()
    
    let walletViewModel = ContainerDI.shared.resolve(WalletViewModel.self)!
    
    var nfcSession: NFCTagReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        runAnim()
        
        setupFloatingPanel()

        navigationItem.title = "Wallet"
        
        baseCanvas.makeCornerRadiusRounded()
        
        card.makeCornerRadius(16)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        card.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.width.height.equalTo(card)
            make.top.left.right.bottom.equalTo(card)
        }
        
//        amountText.text = "Rp0"
        amountText.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        amountText.textColor = .white
        
        amountText.skeletonCornerRadius = 8
        amountText.showAnimatedSkeleton()
        
        card.addSubview(amountText)
        amountText.snp.makeConstraints { make in
            make.centerY.equalTo(self.card)
            make.right.equalTo(self.card).inset(16)
        }
        
        topUpButton.setImage(SFIcon.up, for: .normal)
        topUpButton.setTitle("Top Up", for: .normal)
        topUpButton.backgroundColor = .quaternarySystemFill
        topUpButton.configuration?.imagePlacement = .trailing
        topUpButton.contentHorizontalAlignment = .fill
        topUpButton.setAnimateBounce()
        topUpButton.makeCornerRadius(16)
        topUpButton.addAction(UIAction { _ in
            self.showTopUpPanel()
        }, for: .touchUpInside)
        
        payButton.setImage(SFIcon.down, for: .normal)
        payButton.setTitle("Pay", for: .normal)
        payButton.backgroundColor = .quaternarySystemFill
        payButton.configuration?.imagePlacement = .trailing
        payButton.contentHorizontalAlignment = .fill
        payButton.setAnimateBounce()
        payButton.makeCornerRadius(16)
        payButton.addAction(UIAction { _ in
            let qrCodeVC = BarcodeScannerViewController()
            qrCodeVC.delegate = self
            self.navigationController?.openBottomSheet(to: qrCodeVC)
        }, for: .touchUpInside)
        
        keyboardObserver.observe { [weak self] (event) -> Void in
            guard let self = self else { return }
            switch event.type {
            case .willShow:
                self.floatingPanelController.move(to: .full, animated: true)
            case .willHide:
                self.floatingPanelController.move(to: .half, animated: true)
            default:
                break
            }
        }
        
        transSection.onRemoveItem = { index in
            self.updateAmount()
        }
        transSection.isLoading = true
        
        walletViewModel.getWalletFB {
            self.updateAmount()
            self.transSection.isLoading = false
            self.transSection.table.reloadData()
        } onError: { error in
            AlertKitAPI.present(
                title: error.message ?? "Error load User Wallet",
                icon: AlertIcon.error,
                style: .iOS17AppleMusic,
                haptic: .error
            )
        }
    }
    
    func runAnim() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 2.0
        
        card.layer.add(animation, forKey: "colorChange")
    }
    
    func updateAmount() {
        amountText.hideSkeleton()
        let total = self.walletViewModel.getTotalAmount()
        self.amountText.rx.text.onNext("Rp\(NSNumber(value:total).formatAsDecimalString())")
    }
}

extension WalletViewController: FloatingPanelControllerDelegate, NFCTagReaderSessionDelegate, BarcodeScannerViewControllerDelegate {
    func setupFloatingPanel() {
        floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = self
        
        floatingPanelController.surfaceView.makeCornerRadius(24)
        
        floatingPanelController.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatingPanelController.isRemovalInteractionEnabled = true
    }
    
    func showTopUpPanel() {
        let panelVC = TopUpPanelViewController()
        panelVC.onTapClose = { self.hidePanel() }
        panelVC.didFailAdd = { error in
            self.hidePanel()
            AlertKitAPI.present(
                title: error.message ?? "Error add transactions",
                icon: AlertIcon.error,
                style: .iOS17AppleMusic,
                haptic: .error
            )
        }
        panelVC.didSuccessAdd = {
            self.updateAmount()
            self.transSection.table.reloadData()
            self.hidePanel()
        }
        floatingPanelController.set(contentViewController: panelVC)
        present(floatingPanelController, animated: true, completion: nil)
    }
    
    func hidePanel() {
        floatingPanelController.dismiss(animated: true)
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return TopUpFloatingPanelLayout()
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForPresentingTo state: FloatingPanelState) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: TimeInterval(0.16), curve: .easeOut)
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForDismissingWith velocity: CGVector) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: TimeInterval(0.16), curve: .easeOut)
    }
    
    func startNFCSession() {
        nfcSession = NFCTagReaderSession(pollingOption: [.iso14443], delegate: self)
        nfcSession?.begin()
    }
    
    // NFCTagReaderSessionDelegate methods
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        // Session started
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        // Handle session invalidation or errors
        print("Error: \(error.localizedDescription)")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        for tag in tags {
            switch tag {
            case .feliCa(let felicaTag):
                // Assuming the card contains a simple text-based identifier
                let identifierData = felicaTag.currentIDm
                let identifierString = String(data: identifierData, encoding: .utf8)
                print("Card Identifier: \(identifierString ?? "Unknown")")
                
            case .miFare(let miFareTag):
                // Assuming the card contains a simple text-based identifier
                let identifierData = miFareTag.identifier
                let identifierString = String(data: identifierData, encoding: .utf8)
                print("Card Identifier: \(identifierString ?? "Unknown")")
                
            default:
                // Handle other types of NFC tags if needed
                print("Detected NFC tag of unknown type")
            }
        }
    }
    
    func didScanBarcodeWithResult(_ controller: BarcodeScannerViewController?, scanResult: ScanResult) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.showAlertOK(title: "QR Success", message: scanResult.rawContent)
        }
    }
    
    func didFailWithErrorCode(_ controller: BarcodeScannerViewController?, errorCode: String) {
        
    }
}

class TopUpFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.48, edge: .bottom, referenceGuide: .safeArea),
        .full: FloatingPanelLayoutAnchor(fractionalInset: 0.72, edge: .bottom, referenceGuide: .safeArea),
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        if state == .half || state == .full {
            return 0.64
        } else {
            return 0
        }
    }
}

class TopUpPanelViewController: UIViewController {
    
    var onTapClose: (() -> Void)?
    var didSuccessAdd: (() -> Void)?
    var didFailAdd: ((ErrorService) -> Void)?
    
    let boxTopBar = UIView()
    
    let disposeBag = DisposeBag()
    
    let walletViewModel = ContainerDI.shared.resolve(WalletViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        setupContent()
    }
    
    func setupContent() {
        
        view.backgroundColor = .systemBackground
    
        var amountTemp: String?
        let amountField = UITextField()
        amountField.backgroundColor = .clear
        amountField.keyboardType = .numberPad
        amountField.placeholder = "Rp 0"
        
        let baseAmountField = UIView()
        view.addSubview(baseAmountField)
        baseAmountField.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(self.boxTopBar.snp.bottom).offset(16)
        }
        baseAmountField.backgroundColor = .quaternarySystemFill
        baseAmountField.makeCornerRadius(8)
        
        baseAmountField.addSubview(amountField)
        amountField.snp.makeConstraints { make in
            make.left.equalTo(baseAmountField).inset(8)
            make.right.equalTo(baseAmountField).inset(8)
            make.top.bottom.equalTo(baseAmountField)
        }
        amountField.rx.text
            .compactMap { $0 }
            .map { text in
                return text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            }
            .map { text in
                amountTemp = text
                if let double = Double(text) {
                    let num = NSNumber(value: double)
                    return num.formatAsDecimalString()
                } else {
                    return ""
                }
            }
            .bind(to: amountField.rx.text)
            .disposed(by: disposeBag)
        
        let labelField = UITextField()
        labelField.backgroundColor = .clear
        labelField.placeholder = "Nama"
        
        let baseLabelField = UIView()
        view.addSubview(baseLabelField)
        baseLabelField.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(amountField.snp.bottom).offset(16)
        }
        baseLabelField.backgroundColor = .quaternarySystemFill
        baseLabelField.makeCornerRadius(8)
        
        baseLabelField.addSubview(labelField)
        labelField.snp.makeConstraints { make in
            make.left.equalTo(baseLabelField).inset(8)
            make.right.equalTo(baseLabelField).inset(8)
            make.top.bottom.equalTo(baseLabelField)
        }
        labelField.rx.text
            .compactMap { $0 }
            .bind(to: labelField.rx.text)
            .disposed(by: disposeBag)
        
        let addBtn = UIButton(configuration: .filled())
        addBtn.setTitle("Top Up", for: .normal)
        addBtn.setAnimateBounce()
        
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(baseLabelField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        addBtn.addAction(UIAction { _ in
            if let amount = Double(amountTemp ?? "") {
                let loading = Loading()
                loading.show()
                self.walletViewModel.addTrans(label: labelField.text ?? "-", amount: amount, type: .income) {
                    loading.hide()
                    self.didSuccessAdd?()
                } onError: { error in
                    self.didFailAdd?(error)
                }
            } else {
                self.didFailAdd?(ErrorService(message: "Amount is not found"))
            }
        }, for: .touchUpInside)
    }
    
    func setupTopBar() {
        view.addSubview(boxTopBar)
        boxTopBar.backgroundColor = .secondarySystemBackground
        boxTopBar.addBorderLine(width: 1, color: .separator)
        boxTopBar.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.view.snp.top)
            make.left.right.equalTo(self.view)
        }
        
        let closeBtn = UIButton(configuration: .gray())
        closeBtn.setImage(SFIcon.close?.resizeWith(size: CGSize(width: 12, height: 12)), for: .normal)
        closeBtn.configuration?.cornerStyle = .capsule
        closeBtn.setAnimateBounce()
        boxTopBar.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalTo(self.boxTopBar)
            make.right.equalTo(boxTopBar.snp.right).offset(-16)
        }
        closeBtn.addAction(UIAction { _ in
            self.onTapClose?()
        }, for: .touchUpInside)
    }
}

class HalfCircle: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .systemBackground
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Get the context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set the fill color
        let fillColor = UIColor.accent.withAlphaComponent(0.48)
        fillColor.setFill()
        
        // Calculate the center and radius for the half-circle
        let centerX = rect.width / 2
        let centerY = rect.height
        let radius = rect.width / 2
        
        // Draw the filled half-circle
        context.move(to: CGPoint(x: centerX - radius, y: centerY))
        context.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        context.fillPath()
    }
}


#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct MyViewController_Preview: PreviewProvider {
    static var previews: some View {
        WalletViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif

