//
//  AddPageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 31/10/23.
//

import UIKit
import Lottie

class AddPageViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var loadingAnimation: LottieAnimationView!
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    let days = Array(1...31)

    let years = Array(1900...2100)

    var onCancel: (() -> Void)?
    var onSave: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.navigationItem.title = "Add"
        self.navigationItem.titleView?.backgroundColor = .clear
        
        let cancelButton = UIBarButtonItem(title: "Cancel" , style: .plain, target: self, action: #selector(didTapCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Save" , style: .plain, target: self, action: #selector(didTapSaveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        
        loadingAnimation.play()
        loadingAnimation.loopMode = .loop
        loadingAnimation.contentMode = .center
    }
    
    @objc func didTapCancelButton() {
        onCancel?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSaveButton() {
        onSave?()
        dismiss(animated: true, completion: nil)
    }
}

extension AddPageViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Date, Month, Year
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: // Days
            return days.count
        case 1: // Months
            return months.count
        case 2: // Years
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: // Days
            return String(days[row])
        case 1: // Months
            return months[row]
        case 2: // Years
            return String(years[row])
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDay = days[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
        let selectedYear = years[pickerView.selectedRow(inComponent: 2)]

        print("Selected date: \(selectedDay) \(selectedMonth) \(selectedYear)")
    }
}
