//
//  JoinNowViewController.swift
//  GradNext
//
//  Created by Muthu Kumar on 09/06/16.
//  Copyright © 2016 Mk. All rights reserved.
//

import UIKit
import Alamofire
import AlertBar
class JoinNowViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var firstNameTxtField: UITextField!
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var lastNameTxtField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    var selectedValue = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(self, selector: #selector(JoinNowViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        
        firstNameTxtField.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.gray])
        
        lastNameTxtField.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.gray])
        
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.gray])
        
        mobileTextField.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.gray])
        registerForKeyboardNotifications()
     //   self.view.layoutIfNeeded()
      //  blueView.roundCorners([.bottomLeft,.bottomRight], radius: blueView.frame.size.width/2)
    }
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
        
    }
    
    override func viewDidLayoutSubviews()
    {
        submitButton.layer.cornerRadius = 3
      
        Utilities.setTextFieldBorderBelow(forTextField: lastNameTxtField,color: UIColor.gray)
        Utilities.setTextFieldBorderBelow(forTextField: firstNameTxtField,color: UIColor.gray)
        Utilities.setTextFieldBorderBelow(forTextField: mobileTextField,color: UIColor.gray)
        Utilities.setTextFieldBorderBelow(forTextField: emailTxtField,color: UIColor.gray)
        
        
    }
    /*
 
     {
     
     "UserFirstName": "sara",
     "UserLastName": "raj",
     "EmailId": "testlab7027@gmail.com",
     "MobileNumber": "9788768693",
     "UserOptionCode": "CAND",
     "AddressLine1": "GUINDY",
     "AddressLine2": "CHENNAI",
     "SuburbName": "TN",
     "StateName": "TN",
     "CountryName": "INDIA",
     "PostCode": "600028",
     "PasswordDesc": "123",
     }
*/
    @IBAction func SignUp(_ sender: Any) {
        

        var messageString = "";
        var value  = false
        
        if(firstNameTxtField.text == "")
        {
            messageString = "Please enter your first Name"
            submitButton.isEnabled  = value
            AlertBar.show(.info, message: messageString)
            
            firstNameTxtField.becomeFirstResponder()
        }
        else if(lastNameTxtField.text == "")
        {
            messageString = "Please enter your last Name "
            submitButton.isEnabled  = value
            AlertBar.show(.info, message: messageString)
            lastNameTxtField.becomeFirstResponder()
        }
        else if(emailTxtField.text == "")
        {
            messageString = "Please enter your Email-id"
            submitButton.isEnabled  = value
            AlertBar.show(.info, message: messageString)
            
            emailTxtField.becomeFirstResponder()
            
        }
        else if((Utilities.isValidEmail(testStr :emailTxtField.text! as String)) == false)
        {
            messageString = "Please enter a valid Email-id"
            submitButton.isEnabled  = value
            AlertBar.show(.info, message: messageString)
            
            emailTxtField.becomeFirstResponder()
        }
        else if(mobileTextField.text == "")
        {
            messageString = "Please enter your mobile number"
            submitButton.isEnabled  = value
            AlertBar.show(.info, message: messageString)
            
            mobileTextField.becomeFirstResponder()
        }
            
        else if(selectedValue == "")
        {
            
            messageString = "Please Select Company or Candidate"

            submitButton.isEnabled  = value

            AlertBar.show(.info, message: messageString)

        }
            
        else
        {
            if(Utilities.hasConnectivity())
            {
                self.view.showLoader()
                
                    let parameters: [String: String] = ["UserFirstName":firstNameTxtField.text!,"UserLastName": lastNameTxtField.text!, "EmailId": emailTxtField.text!,"MobileNumber":mobileTextField.text!,"UserOptionCode":selectedValue]
                
                    let url = URL(string: "http://service.gradnext.com/api/User/RegisterUser")!
                    var urlRequest = URLRequest(url: url)
                    urlRequest.httpMethod = "POST"
                    do {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    } catch {
                    }
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    Alamofire.request(urlRequest).responseJSON {
                        response in
                        switch response.result {
                        case .success:
                            if let value = response.result.value {
                                
                                 let final =  value as! [String : Any]
                                
                                if (final["StatusMessage"] as! String == "Registration Successful")
                                {
                                messageString = "Thank you for registering.Your Profile has been created and an activation link has been sent to your email ."
                                
                                self.alert(title:  "Success", message: messageString, buttonTitle: "Ok")

                                }
                                else{
                                    self.alert(title:  "Success", message: final["StatusMessage"] as? String, buttonTitle: "Ok")

                                }
                            
                            }
                        case .failure(let error):
                            print(error)
                        }
                        

                    self.view.hideLoader()
                    value = true
                    self.emailTxtField.text = "";
                    self.lastNameTxtField.text = "";
                    self.firstNameTxtField.text = "";
                    self.mobileTextField.text = "";

                    self.view.endEditing(true)
                    self.submitButton.isEnabled  = value
                }
            }
            else
            {
                alert(title: "No InternetConnection", message: "Internet connection appears to be offline", buttonTitle: "Ok")
                
                self.submitButton.isEnabled  = true
            }
        }


        
        
    }
    
    func methodOfReceivedNotification(notification: NSNotification){
        //Take Action on Notification
        submitButton.isEnabled  = true
    }
    
    @IBAction func exitAction(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        // Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.blue)
        // Utilities.setTextFieldBorderBelow(forTextField: textField,color: UIColor.blue)
        
        
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        //Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.gray)
        //  Utilities.setTextFieldBorderBelow(forTextField: textField,color: UIColor.gray)
        activeField = nil
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
                selectedValue = "CAND"
                
            }
        } else {
            
            selectedValue = "COMP"
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //        Alamofire.request("http://service.gradnext.com/swagger/ui/index#!/User/User_SignInUser", method: .post, parameters: ["UserFirstName":"Mk","UserLastName": "kumar", "EmailId": "muthukumar.test@gmail.com","MobileNumber":"9500172887","UserOptionCode":"CAND",]).responseJSON{ (responseData) -> Void in
    //            if((responseData.result.value) != nil) {
    //
    //
    //                print(responseData.result.value!)
    //            }
    //            else
    //            {
    //                print(Error.self)
    //            }
    //            
    //        }
}
