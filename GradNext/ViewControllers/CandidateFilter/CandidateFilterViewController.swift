//
//  CandidateFilterViewController.swift
//  GradNext
//
//  Created by Aravind on 5/14/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class CandidateFilterViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtKeywords: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtSkills: UITextField!
    
    @IBOutlet weak var btnApply: UIButton!
    
    var activeField: UITextField?
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews()
    {
       customControls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
       registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
        
    }

    func customControls() {
        
        Utilities.setTextFieldCornerRadius(forTextField: txtKeywords, withRadius: 3.0, withBorderColor:  UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: txtSkills, withRadius: 3.0, withBorderColor:  UIColor.gray)
        
        Utilities.setButtonCornerRadius(button: btnFilter, withRadius: 3.0, withBorderColor: UIColor.gray)
        
        txtSkills.setLeftPaddingPoints(10)
        txtKeywords.setLeftPaddingPoints(10)
        
        
        
        btnApply.layer.cornerRadius = 3.0
        btnReset.layer.cornerRadius = 3.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func applyButtonClicked(_ sender: Any) {
    }
   
    @IBAction func resetButtonClicked(_ sender: Any) {
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
         Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.blue)
        // Utilities.setTextFieldBorderBelow(forTextField: textField,color: UIColor.blue)
        
        
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.gray)
        //Utilities.setTextFieldBorderBelow(forTextField: textField,color: UIColor.gray)
        activeField = nil
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
