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

class WalletViewController: BaseViewController {

    @IBOutlet weak var base: UIView!
    @IBOutlet weak var card: Card!

    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var transSection: TransSection!
    
    let amountText = UILabel()
    
    var floatingPanelController: FloatingPanelController!
    
    let keyboardObserver = KeyboardObserver()
    
    let walletViewModel = ContainerDI.shared.resolve(WalletViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        runAnim()
        
        setupFloatingPanel()

        navigationItem.title = "Wallet"

        base.backgroundColor = .systemBlue
        
        card.makeCornerRadius(16)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        card.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.width.height.equalTo(card)
            make.top.left.right.bottom.equalTo(card)
        }
        
        amountText.text = "Rp0"
        amountText.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        amountText.textColor = .white
        
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
            self.navigationController?.openBottomSheet(to: ScannerViewController())
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
    }
    
    func runAnim() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 2.0
        
        card.layer.add(animation, forKey: "colorChange")
    }
    
    func updateAmount() {
        let total = self.walletViewModel.getTotalAmount()
        self.amountText.rx.text.onNext("Rp\(NSNumber(value:total).formatAsDecimalString())")
    }
}

extension WalletViewController: FloatingPanelControllerDelegate {
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
        panelVC.didFailAdd = { self.hidePanel() }
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
}

class TopUpFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.32, edge: .bottom, referenceGuide: .safeArea),
        .full: FloatingPanelLayoutAnchor(fractionalInset: 0.64, edge: .bottom, referenceGuide: .safeArea),
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
    var didFailAdd: (() -> Void)?
    
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
                    return currencyFormatter.string(from: num)
                } else {
                    return ""
                }
            }
            .bind(to: amountField.rx.text)
            .disposed(by: disposeBag)
        
        let addBtn = UIButton(configuration: .filled())
        addBtn.setTitle("Top Up", for: .normal)
        addBtn.setAnimateBounce()
        
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(baseAmountField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        addBtn.addAction(UIAction { _ in
            print(amountTemp ?? "-")
            if let amount = Double(amountTemp ?? "") {
                self.walletViewModel.addTrans(label: "Top Up", amount: amount, type: .income)
                self.didSuccessAdd?()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.didFailAdd?()
                }
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

