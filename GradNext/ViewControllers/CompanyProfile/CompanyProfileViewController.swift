//
//  CompanyProfileViewController.swift
//  GradNext
//
//  Created by Aravind on 5/4/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit
import AlertBar
import Alamofire

class CompanyProfileViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
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
    let pickerView = UIPickerView()
    var activeField: UITextField?
    var activeTextView: UITextView?
    var suburbs = NSArray();
    var state = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customViews()
        imagePicker.delegate = self
        self.title = "Company Profile"
        
        pickerView.dataSource = self
        pickerView.delegate = self
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
        if(textField == txtSuburb){
        txtSuburb.inputView = pickerView
        self.showTimePicker(textField: txtSuburb)
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
         Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.gray)
        activeField = nil
        if(textField == txtPostCode)
        {
            self.postcodeparser()
        }
    }
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeTextView = textView
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeTextView = nil
        
    }
    
    func postcodeparser(){
    if(txtPostCode.text == "")
            {
                AlertBar.show(.info, message: "Please enter your postcode")
                
                txtPostCode.becomeFirstResponder()
            }
            else
            {
                if(Utilities.hasConnectivity())
                {
                    self.view.showLoader()
                    //               http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=2600
                    
                    let url1 = URL(string: "http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=\(txtPostCode.text!)")!
                    
                    var urlRequest = URLRequest(url: url1)
                    urlRequest.httpMethod = "POST"
                    do {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: [] , options: [])
                    } catch {
                    }
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    Alamofire.request(urlRequest).responseJSON {
                        response in
                        switch response.result {
                        case .success:
                            if let value = response.result.value {
                                
                                let final =  value as! [String : Any]
                                print(final)
                                self.suburbs = final["Suburbs"] as! NSArray
                                print(self.suburbs)
                                print(self.suburbs.count)
                                self.state = final["States"] as! NSArray
                                print(self.state[0]);
                                self.pickerView.reloadAllComponents()
                                
                            }
                        case .failure(let error):
                            print(error)
                        }
                        self.view.hideLoader()
                        
                        self.view.endEditing(true)
                    }
                }
                    
                else
                {
                    
                    alert(title: "No InternetConnection", message: "Internet connection appears to be offline", buttonTitle: "Ok")
                }
                
            }
            
        
    }
  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        //        return 2
        if(suburbs.count != 0)
        {
            return suburbs.count
        }
        else
        {
            return 1;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(suburbs.count != 0)
        {
            txtSuburb.text = "Select the Suburbs"
            return suburbs[row] as? String
        }
        else
        {
            return "Please Enter Post Code"
        }
        //        return "hello";
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(suburbs.count != 0 )
        {
        txtSuburb.text = (suburbs[row] as! String)
        txtState.text = (state[0] as! String)
        }
        else
        {
            txtSuburb.text = "Please Enter Post Code"
        }
    }
    func showTimePicker(textField: UITextField) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CompanyProfileViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Select your Suburb"
        label.textAlignment = NSTextAlignment.center
        
        //        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([flexSpace,flexSpace,okBarBtn], animated: true)
        
        textField.inputAccessoryView = toolBar
    }
    
    func donePressed(_ sender: UITextField) {
        
        txtSuburb.resignFirstResponder()
        self.view.endEditing(true)
        
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

