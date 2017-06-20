//
//  ExploreViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 5/27/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SDWebImage


class ExploreViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    let scrollView  = UIScrollView()

    var temp  = 0
    var nameArray = [String]()
    var imageLocoArray = [String]()
    var imageIconArray = [String]()
    var stateName = [String]()
    var SuburbName = [String]()
    var PostCode = [String]()
    var CompanyDescription = [String]()



    var imageurl = ""
    var companyName = ""
    var companyDetail = ""
    var address = ""
    var finalString = ""
    

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
        
        print(self.view.frame.size.width * CGFloat((sender as AnyObject).tag))
        scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width * CGFloat((sender as AnyObject).tag), y: 0),animated: true)

//        gotoLogin()
    }
    
    func jsonParser(string : String)
    {
        if(Utilities.hasConnectivity())
        {
            tableView.showLoader()
            
            //            self.view.showLoader()
            
            let url = URL(string: string)!
                
            let urlRequest = URLRequest(url: url)
            
            Alamofire.request(urlRequest).responseJSON {
                response in
                switch response.result {
                case .success:
                    
                    if let value = response.result.value {
                        
                        let final =  value as! [String : Any]
                        if let result = final["CompanyList"] as? NSArray {
                            
                            print(result.count)
                            
                            for values in result {
                                
                                if let value = values as? [String:Any] {
                            //CompanyDescription
            self.CompanyDescription.append(value["CompanyDescription"]! as! String)
            self.imageLocoArray.append(value["LogoPath"]! as! String)
                         //CompanyName
            self.nameArray.append(value["CompanyName"]! as! String)
                                    //IconPath
             self.imageIconArray.append(value["IconPath"]! as! String)

            self.stateName.append(value["StateName"]! as! String)
             self.SuburbName.append(value["SuburbName"]! as! String)
              self.PostCode.append(value["PostCode"]! as! String)
                         
                                    print(values)
                                    
                                }
                            }
                        }
                        self.tableView?.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
                
                self.tableView.hideLoader()
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5)
        leftButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0x800000), for: .normal)
        
        RightButton.backgroundColor = Utilities.UIColorFromRGB(rgbValue: 0xe33936)
        RightButton.setTitleColor(Utilities.UIColorFromRGB(rgbValue: 0xf5f5f5), for: .normal)
        
               let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "GradNext");
        let doneItem = UIBarButtonItem(image: UIImage(named:"filter"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoLogin));
        

        let leftItem = UIBarButtonItem(image: UIImage(named:"message"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoLogin))
            
   
           let leftItem1 =  UIBarButtonItem(image: UIImage(named:"ic_notifications_black_24dp"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoLogin))

        
        navItem.leftBarButtonItems = [leftItem,leftItem1];
        
        navItem.rightBarButtonItem = doneItem;

        navBar.setItems([navItem], animated: false)
        
       self.title = "Home"
//        self.navigationController?.navigationBar.topItem?.title = "GradNext";
        
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
        
        //http://service.gradnext.com/api/Company/GetAllCompany?PageNumber=1&RowsPerPage=10

        jsonParser(string: "http://service.gradnext.com/api/Company/GetAllCompany?PageNumber=1&RowsPerPage=10")
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
            return 1
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
        Label.textColor = UIColor.lightGray
        Label.textAlignment = .center
        cell?.addSubview(Label)

        if( tableView.tag == 0)
        {
            print(imageIconArray);
//            let url = URL(string: "http://service.gradnext.com/Userimage/Company/19_COMP_LOGO.png" )
            cell?.imageView?.sd_setImage(with: URL(string: "http://service.gradnext.com/Userimage/Company/19_COMP_LOGO.png" ), placeholderImage: UIImage(named: "placeholder.png"))
            //used a place holder image to initialise the imageview
        
            cell?.textLabel?.text = "F#"
            cell?.detailTextLabel?.text = "Accenture"
            Label.text = "12 days Left"


        }

        else
        {
            cell?.textLabel?.text = self.nameArray[indexPath.row]
            // self.imageArray

            cell?.imageView?.sd_setImage(with:URL(string: "http://service.gradnext.com\(self.imageIconArray[indexPath.row])" )  , placeholderImage: UIImage(named: "placeholder.png") )
//            
//            let url2 = URL(string: "http://service.gradnext.com/\(self.imageLocoArray[indexPath.row])" )
//            cell?.imageView?.sd_setImage(with: url2, placeholderImage: UIImage(named: "placeholder.png"))
//            
             finalString = self.stateName[indexPath.row] + "," + self.SuburbName[indexPath.row] + "," + self.PostCode[indexPath.row]
            cell?.detailTextLabel?.text =  finalString
            Label.removeFromSuperview()

        }
        
        
       
        cell?.detailTextLabel?.textColor = UIColor.darkGray
        cell?.detailTextLabel?.font = UIFont(name: "Times New Roman ", size: 12.0)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12.0)
    
        cell?.textLabel?.font = UIFont(name: "Helvetica Neue", size: 13.0)
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
         //changing the text attributes
        
        cell?.imageView?.contentMode = UIViewContentMode.scaleAspectFit
       
        cell?.imageView?.clipsToBounds = true
        
        return  cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if(tableView.tag   == 0)
        {
            

            self.performSegue(withIdentifier: "ExploreJobView", sender: self)
        }
        else{
            
            companyName = self.nameArray[indexPath.row]
            address = finalString
            companyDetail = self.CompanyDescription[indexPath.row]
            companyName = self.nameArray[indexPath.row]
            imageurl = self.imageIconArray[indexPath.row]

            self.performSegue(withIdentifier: "ExploreCompanyView", sender: self)
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "ExploreJobView")
        {
        }
        else
        {
            let viewControl =  segue.destination as! ExploreCompanyViewController
            viewControl.companyName = companyName
            viewControl.imageurl = imageurl
            viewControl.address = address
            viewControl.companyDetail = companyDetail

 
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
