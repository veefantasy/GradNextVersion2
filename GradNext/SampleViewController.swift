//
//  SampleViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 6/24/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit
import Alamofire
import AlertBar

class SampleViewController: UIViewController {
    @IBOutlet var passcodetext: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func click(_ sender: Any) {
        if(passcodetext.text == "")
        {
            AlertBar.show(.info, message: "Please enter your user name")
            
            passcodetext.becomeFirstResponder()
        }
        else
        {
            if(Utilities.hasConnectivity())
            {
                self.view.showLoader()
//               http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=2600
                
                
//                let url = URL(string: "http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=2600")!
                
               
                let url1 = URL(string: "http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=\((passcodetext.text!))")!
                
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
                            //                        let resetsuccessful = final["IsResetSuccessful"] as! Bool
                            //                        print(resetsuccessful)
                            //                        let statusmessage = final["StatusMessage"] as? String
                            //                        print(statusmessage!)
                            //                        if(resetsuccessful==true)
                            //                        {
                            //                            self.alert(title: "Successful", message: statusmessage, buttonTitle: "Ok")
                            //                        }
                            //                        else
                            //                        {
                            //                            self.alert(title: "Reset Unsuccessful", message: statusmessage, buttonTitle: "Ok")
                            //                        }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    self.view.hideLoader()
                    
                    // value = true
                    //                self.userNameTxtField.text = "";
                    //                self.passwordTxtField.text = "";
                    
                    self.view.endEditing(true)
                }
            }
            
            else
            {
                
                alert(title: "No InternetConnection", message: "Internet connection appears to be offline", buttonTitle: "Ok")
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
