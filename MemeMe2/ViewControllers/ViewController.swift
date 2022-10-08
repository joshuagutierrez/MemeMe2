//
//  ViewController.swift
//  MemeMe2
//
//  Created by Josh Gutierrez on 9/19/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationToolbar: UIToolbar!
    
    var memedImage: UIImage!
    

    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        #if targetEnvironment(simulator)
            cameraButton.isEnabled = false
        #else
            cameraButton.isEnabled = true
        #endif

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(textField: topTextField, text: "TOP")
        setupTextField(textField: bottomTextField, text: "BOTTOM")
        
        //disable share button until the image was picked
        shareButton.isEnabled = false
    }
    
    func setupTextField(textField: UITextField, text: String) {
        //setting defaults for text field
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
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
        textField.resignFirstResponder()
        return true
    }
    
  
    func pickImage(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }


    @IBAction func pickAnImage(_ sender:Any) {
        pickImage(source: .photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        <#code#>
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
        //enables share button once user selects photo
        shareButton.isEnabled = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
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
    
    func generateMemedImage() -> UIImage {

        self.toolbar.isHidden = true
        self.navigationToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.toolbar.isHidden = false
        self.navigationToolbar.isHidden = false
        return memedImage
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        // add it to the memes array on the app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }

    @IBAction func shareMeme(_ sender: Any) {
        // generate meme image
        let image = generateMemedImage()
        //define activity controller, pass it memedImage
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //present ActivityViewController
        present(controller, animated: true, completion: nil)
        
        //save Meme
        
        controller.completionWithItemsHandler = { [self]
        _, completed, _, _ in if completed {
            
        _ = (topText: self.topTextField.text! as NSString?, bottomText: self.bottomTextField.text! as NSString?, image: self.imagePickerView.image, memedImage: memedImage)
        //save the image after the user shares the image
        self.save()
        self.dismiss(animated: true, completion: nil)
        }
        }
        
    }
    
    
}

