//
//  CandidateProfileViewController.swift
//  GradNext
//
//  Created by Aravind on 5/5/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class CandidateProfileViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate  {
    @IBOutlet weak var lblAustralia: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnUploadVideo: UIButton!
    @IBOutlet weak var btnAttachResume: UIButton!
    @IBOutlet weak var txtWorkExperience: UITextField!
    @IBOutlet weak var txtYearOfGraduation: UITextField!
    @IBOutlet weak var txtaboutMe: UITextView!
    @IBOutlet weak var lblState: UITextField!
    @IBOutlet weak var lblSuburb: UITextField!
    @IBOutlet weak var lblPostCode: UITextField!
    @IBOutlet weak var lblAddress: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    let imagePicker = UIImagePickerController()
    var activeField: UITextField?
    var activeTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        customViews()
        // Do any additional setup after loading the view.
         registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
        
    }

    @IBAction func addSkillsButtonClicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectSkillsViewController") as! SelectSkillsViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func closeButtonClicked(_ sender: Any) {
          self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func customViews() {
        Utilities.setTextFieldCornerRadius(forTextField: firstName, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lastName, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lblAddress, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lblPostCode, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lblSuburb, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lblState, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: lblAustralia, withRadius: 3.0, withBorderColor: UIColor.gray)
        
        Utilities.setTextFieldCornerRadius(forTextField: txtYearOfGraduation, withRadius: 3.0, withBorderColor: UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: txtWorkExperience, withRadius: 3.0, withBorderColor: UIColor.gray)
        

        
        firstName.setLeftPaddingPoints(10)
        lastName.setLeftPaddingPoints(10)
        lblAddress.setLeftPaddingPoints(10)
        lblPostCode.setLeftPaddingPoints(10)
        lblSuburb.setLeftPaddingPoints(10)
        lblState.setLeftPaddingPoints(10)
        lblAustralia.setLeftPaddingPoints(10)
        txtYearOfGraduation.setLeftPaddingPoints(10)
        txtWorkExperience.setLeftPaddingPoints(10)
        
        txtaboutMe.layer.cornerRadius = 3.0
        txtaboutMe.layer.borderWidth = 1.0
        txtaboutMe.layer.borderColor = UIColor.gray.cgColor
        
        btnCreate.layer.cornerRadius = 3.0
        btnUploadVideo.layer.cornerRadius = 3.0
        btnAttachResume.layer.cornerRadius = 3.0
        
    }
    
   
    @IBAction func uploadVideoButtonClicked(_ sender: Any) {
    }
    
     @IBAction func attachButtonClicked(_ sender: Any) {
     }
    
    @IBAction func createButtonClicked(_ sender: Any) {
    }
    
    @IBAction func btnGalleryClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    @IBAction func editButtonClicked(_ sender: Any) {
    }
    
    @IBAction func btnCameraClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
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
