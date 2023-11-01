//
//  EditProfilePageViewController.swift
//  TimeAndClock
//
//  Created by Eky on 01/11/23.
//

import UIKit

class EditProfilePageViewController: UIViewController {
    
    @IBOutlet weak var showCameraButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var showGalleryButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Edit Profile"
        self.navigationItem.titleView?.backgroundColor = .clear
        
        let cancelButton = UIBarButtonItem(title: "Cancel" , style: .plain, target: self, action: #selector(didTapCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Save" , style: .plain, target: self, action: #selector(didTapSaveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        
        imagePicker.delegate = self
    }
    
    @objc func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSaveButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapShowGalleryButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapShowCameraButton(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
}

extension EditProfilePageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImage.image = pickedImage
            
            var message = ""
            if let predict = GuestImage.shared.processImage(image: pickedImage) {
                message = "The image is \(predict)"
            } else {
                message = "Cannot predict the image"
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
