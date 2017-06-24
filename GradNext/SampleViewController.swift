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

class SampleViewController: UIViewController{
    var suburbs = NSArray();
    var state = NSArray();
    @IBOutlet var postcodetext: UITextField!
    @IBOutlet weak var pickersuburbs: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func click(_ sender: Any) {
        if(postcodetext.text == "")
        {
            AlertBar.show(.info, message: "Please enter your postcode")
            
            postcodetext.becomeFirstResponder()
        }
        else
        {
            if(Utilities.hasConnectivity())
            {
                self.view.showLoader()
//               http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=2600
                
               let url1 = URL(string: "http://service.gradnext.com/api/Job/GetPostalLookup?PostCode=\(postcodetext.text!)")!
                
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
                            print(self.suburbs[5],self.suburbs.count)
                            self.state = final["States"] as! NSArray
                            print(self.state[0]);
                            self.pickersuburbs.reloadComponent(0)
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
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
            return suburbs[row] as? String
        }
        else
        {
            return "nil"
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
