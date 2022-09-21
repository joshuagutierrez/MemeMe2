//
//  ViewController.swift
//  MemeMe1
//
//  Created by Josh Gutierrez on 9/19/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor(named: "black"),
        NSAttributedString.Key.foregroundColor: UIColor(named: "white"),
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  3
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
//#if targetEnvironment(simulator)
//    cameraButton.isEnabled = false;
//#else
//    cameraButton.isEnabled = true;
//#endif
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
         textField.text = ""
    }
        if textField.text == "BOTTOM" {
         textField.text = ""
    }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
    
  
    


    @IBAction func pickAnImage(_ sender:Any) {

        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)

    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        <#code#>
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    
}

