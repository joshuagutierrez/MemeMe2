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
    override func viewWillAppear(_ animated: Bool) {
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
//#if targetEnvironment(simulator)
//    cameraButton.isEnabled = false;
//#else
//    cameraButton.isEnabled = true;
//#endif

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
         textField.text = ""
    }
        if textField.text == "BOTTOM" {
         textField.text = ""
    }
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

    
    
}

