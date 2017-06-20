//
//  PostJobViewController.swift
//  GradNext
//
//  Created by Aravind on 5/14/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class PostJobViewController: UIViewController , UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var txtYearOfGraduation: UITextField!

    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnJobType: UIButton!
    @IBOutlet weak var btnUploadVideo: UIButton!
    @IBOutlet weak var enableVideoQuestionSwitch: UISwitch!
    @IBOutlet weak var txtAboutJob: UITextView!
    @IBOutlet weak var txtJobTitle: UITextField!
    
    var activeField: UITextField?
    var activeTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Post Job"
        self.navigationController?.navigationBar.topItem?.title = "Post Job";
        
        
        self.setNavigationBarItem(controllerName: "Post Job")

        // Do any additional setup after loading the view.
        registerForKeyboardNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if SharedManager.sharedInstance.selectedSkills.count == 0 {
            tableViewHeight.constant = 0
            viewHeight.constant = 720
        } else {
            tableViewHeight.constant = 86
            viewHeight.constant = 800
            
        }
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    @IBAction func skillsButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectSkillsViewController") as! SelectSkillsViewController
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
   
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func postJobButtonClicked(_ sender: Any) {
    }
    
    @IBAction func jobTypeButtonClicked(_ sender: Any) {
    }
    override func viewDidLayoutSubviews()
    {
        customControls()
    }
    func customControls() {
        
        Utilities.setTextFieldCornerRadius(forTextField: txtYearOfGraduation, withRadius: 3.0, withBorderColor:  UIColor.gray)
        Utilities.setTextFieldCornerRadius(forTextField: txtJobTitle, withRadius: 3.0, withBorderColor:  UIColor.gray)
        
        Utilities.setButtonCornerRadius(button: btnJobType, withRadius: 3.0, withBorderColor: UIColor.gray)
        
        txtYearOfGraduation.setLeftPaddingPoints(10)
        txtJobTitle.setLeftPaddingPoints(10)
        
        
        btnJobType.imageEdgeInsets = UIEdgeInsetsMake(0, btnJobType.frame.size.width - 40, 0, 0)
        btnJobType.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20)
        
        txtAboutJob.layer.cornerRadius = 3.0
        txtAboutJob.layer.borderWidth = 1.0
        txtAboutJob.layer.borderColor = UIColor.gray.cgColor
        
        btnUploadVideo.layer.cornerRadius = 3.0
        btnSubmit.layer.cornerRadius = 3.0
        
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
        
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0.0)
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
        Utilities.setTextViewCornerRadius(forTextView: textView, withRadius: 3.0, withBorderColor: UIColor.blue)
        activeTextView = textView
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
         Utilities.setTextViewCornerRadius(forTextView: textView, withRadius: 3.0, withBorderColor: UIColor.gray)
        activeTextView = nil
    }

    //MARK: Tableview delegates and datasources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView( _ tableView: UITableView, heightForHeaderInSection section: Int ) -> CGFloat
    {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return SharedManager.sharedInstance.selectedSkills.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "SkillsResultTableViewCell") as! SkillsResultTableViewCell
        
        notificationsCell.lblSkills.text = SharedManager.sharedInstance.selectedSkills[indexPath.row]
        return notificationsCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
