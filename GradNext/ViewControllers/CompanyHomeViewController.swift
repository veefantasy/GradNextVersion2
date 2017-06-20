//
//  CompanyHomeViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 5/21/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class CompanyHomeViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    let scrollView  = UIScrollView()
    
    var temp  = 0
    var nameArray = [String]()
    var imageArray = [String]()
    var CompanyName = [String]()
    var hoursLeftArray = [String]()

    
    var tableView : UITableView!
    
    @IBAction func SearchJobsAction(_ sender: Any) {
        
        if (((sender as AnyObject).tag) == 0)
        {
            leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
            leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
            
            RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
            RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
        }
        else
        {
            RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
            RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
            
            leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
            leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
            
        }
        
        scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width * CGFloat((sender as AnyObject).tag), y: 0),animated: true)
        
    }
    
    //http://service.gradnext.com/api/Job/GetCompOpenJobs
    //   let parameters: [String: String] = ["CompanyId":"10"]

    
    func JSonParser(url :String , param : [String :String])
    {
        //http://service.gradnext.com/api/Job/GetCompOpenJobs

        if(Utilities.hasConnectivity())
        {
            tableView.showLoader()
            
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
                        if let result = final["jobs"] as? NSArray {
                            print(result)
                            
                            print(result.count)
                            
                            for values in result {
                                
                                if let value = values as? [String:Any] {
                                    self.hoursLeftArray.append(value["JobTitleName"]! as! String)
                                    self.nameArray.append(value["JobTitleName"]! as! String)
                                    self.CompanyName.append(value["CompanyName"]! as! String)
                                }
                            }
                        }
                        self.tableView?.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                self.tableView.hideLoader()
                
                //                value = true
                
            }
            
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
        leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
        
        RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
        RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
        
               self.title = UserDefaults.standard.value(forKey: "UserDetailLabel") as! String?
        
        scrollView.frame =  CGRect(x: 0, y:  headerView.frame.origin.y+headerView.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height-headerView.frame.origin.y+headerView.frame.size.height )
        scrollView.tag = 101
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.size.width*2, height:self.view.frame.size.height-headerView.frame.origin.y+headerView.frame.size.height)
        self.view.addSubview(scrollView)
        
        
        
        for  i in 0...1
        {
            
        
            tableView = UITableView()
            tableView.frame = CGRect( x: self.view.frame.size.width * CGFloat(i), y: 0, width: self.view.frame.size.width, height: scrollView.frame.size.height)
            tableView.dataSource  = self
            tableView.delegate = self
            tableView.tag  = i
            tableView.backgroundColor = UIColor.white
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            scrollView.addSubview(tableView)
        }
        //http://service.gradnext.com/api/Job/GetCompOpenJobs

        let parameters: [String: String] = ["CompanyId":"10"]
        
        JSonParser(url: "http://service.gradnext.com/api/Job/GetCompOpenJobs", param: parameters)
//        if(tableView.tag == 0)
//        {
//            
//        
//            
//        }
//            
//        else
//        {
//            
//            //http://service.gradnext.com/api/Job/GetCompOpenJobs
//            //   let parameters: [String: String] = ["CompanyId":"10"]
//            //JSonParser(url: String, param: <#T##[String : String]#>)
//            
//        }
        
        self.setNavigationBarItem(controllerName: "Home")
        
        
        // Do any additional setup after loading the view.
    }
    
    func gotoLogin()
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController =  appDelegate.LandingView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)    {
        
        if( scrollView.tag == 101)
        {
            if (scrollView.contentOffset.x == 0)
            {
                leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
                leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
                
                RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
                RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
            }
            else
            {
                RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
                RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
                
                leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
                leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView.tag == 0)
        {
            return 10
        }
        else{
            
            if(self.nameArray.count > 0)
            {
                return (self.nameArray.count)
            }
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myIdentifier")
        let Label = UILabel(frame: CGRect(x: 250, y: 15, width: 100, height: 21))
        Label.font = UIFont.italicSystemFont(ofSize: 16.0)
        Label.textAlignment = .center
       
               let Thumb = UIImage(named: "jobs")
        cell?.imageView?.image = Thumb
        
        if( tableView.tag == 0)
        {
          
            Label.text = "Expired"
            cell?.textLabel?.text="Job Test"
            
        }
            
        else
        {
            
            Label.text = "Expired"
            cell?.addSubview(Label)
            
            cell?.textLabel?.text=self.nameArray[indexPath.row]
            
            cell?.detailTextLabel?.text=self.CompanyName[indexPath.row]
           
//            Label.text = self.nameArray[indexPath.row]

       //     cell?.addSubview(Label)
            
            
            
            // self.imageArray
            // let url = URL(string: "http://service.gradnext.com/\(self.imageArray[indexPath.row])" )
            //    cell?.imageView?.sd_setImage(with: url)
            
        }
        
        cell?.addSubview(Label)

        return  cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if(tableView.tag   == 0)
        {
            //self.performSegue(withIdentifier: "ExploreJobView", sender: self)
            print("Jobview")
        }
        else{
            //self.performSegue(withIdentifier: "ExploreCompanyView", sender: self)
            print("CompanyView")
        }
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     
    
}
