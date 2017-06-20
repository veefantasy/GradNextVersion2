//
//  CompanySearchTalentViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 6/18/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit
import Alamofire
class CompanySearchTalentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        func JSonParser(url :String , param : [String :String])
        {
            //http://service.gradnext.com/api/Job/GetCompOpenJobs
            
            if(Utilities.hasConnectivity())
            {
                let parameters: [String: String] = param
                let url = URL(string: url)!
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
                        print(response.result)
                        let parameters: [String: String] = ["CompanyId":"10"]
                        
                        JSonParser2(url: "http://service.gradnext.com/api/Job/GetCompExpiredJobs", param: parameters)

                        
                        if let value = response.result.value {
                            
                            
                            let final =  value as! [String : Any]
                            if let result = final["jobs"] as? NSArray {
                                print(result)
                                
                                
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                    self.view.hideLoader()
                    
                    //                value = true
                    
                }
                
            }
            
        }
        
        func JSonParser2(url :String , param : [String :String])
        {
            //http://service.gradnext.com/api/Job/GetCompOpenJobs
            
            if(Utilities.hasConnectivity())
                
            {
                
                let parameters: [String: String] = param
                let url = URL(string: url)!
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
                        print(response.result)
                        
                        if let value = response.result.value {
                            
                            
                            let final =  value as! [String : Any]
                            print(final)
                            
                            if let result = final["jobs"] as? NSArray {
                                print(result)
                                
                                
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                    self.view.hideLoader()
                    
                    //                value = true
                    
                }
                
            }
            
        }

        self.title = "Search Talent"
        self.navigationController?.navigationBar.topItem?.title = "Search Talent";
        self.setNavigationBarItem(controllerName: "Search Talent")
        
        let parameters: [String: String] = ["CompanyId":"10"]
        
        JSonParser(url: "http://service.gradnext.com/api/Job/GetCompOpenJobs", param: parameters)
        
        

        // Do any additional setup after loading the view.
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
