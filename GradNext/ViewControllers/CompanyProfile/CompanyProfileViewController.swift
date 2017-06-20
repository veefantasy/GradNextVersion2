//
//  CompanyProfileViewController.swift
//  GradNext
//
//  Created by Aravind on 5/4/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class CompanyProfileViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var txtAboutUs: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtSuburb: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var activeField: UITextField?
    var activeTextView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        customViews()
        imagePicker.delegate = self
        self.title = "Company Profile"
        // Do any additional setup after loading the view.
        registerForKeyboardNotifications()
    }
  
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
        
    }

    func customViews() {
         Utilities.setTextFieldCornerRadius(forTextField: txtCompanyName, withRadius: 3.0, withBorderColor: UIColor.gray)
         Utilities.setTextFieldCornerRadius(forTextField: txtAddress, withRadius: 3.0, withBorderColor: UIColor.gray)
         Utilities.setTextFieldCornerRadius(forTextField: txtPostCode, withRadius: 3.0, withBorderColor: UIColor.gray)
         Utilities.setTextFieldCornerRadius(forTextField: txtCountry, withRadius: 3.0, withBorderColor: UIColor.gray)
         Utilities.setTextFieldCornerRadius(forTextField: txtState, withRadius: 3.0, withBorderColor: UIColor.gray)
         Utilities.setTextFieldCornerRadius(forTextField: txtSuburb, withRadius: 3.0, withBorderColor: UIColor.gray)
        
        txtAddress.setLeftPaddingPoints(10)
        txtPostCode.setLeftPaddingPoints(10)
        txtCountry.setLeftPaddingPoints(10)
        txtState.setLeftPaddingPoints(10)
        txtSuburb.setLeftPaddingPoints(10)
        txtCompanyName.setLeftPaddingPoints(10)
        
        txtAboutUs.layer.cornerRadius = 3.0
        txtAboutUs.layer.borderWidth = 1.0
        txtAboutUs.layer.borderColor = UIColor.gray.cgColor
        
        btnCreate.layer.cornerRadius = 3
    }
    
     // MARK: - Button Actions
    
    @IBAction func btnPhotoLibraryClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnCameraClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createButtonClicked(_ sender: Any) {
          let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = appDelegate.companyMenuView()
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textViewShouldReturn(textView: UITextView!) -> Bool {
        
        textView.resignFirstResponder()
        return false;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
        
        if let activeTextView = self.activeTextView {
            if (!aRect.contains(activeTextView.frame.origin)){
                self.scrollView.scrollRectToVisible(activeTextView.frame, animated: true)
            }
        }
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.blue)
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
         Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.gray)
        activeField = nil
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeTextView = textView
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeTextView = nil
    }

  
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

