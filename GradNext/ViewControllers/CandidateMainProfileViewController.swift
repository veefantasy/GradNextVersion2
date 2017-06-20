
//  ViewController.swift
//  candidateProfile
//
//  Created by Aravind on 5/16/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

import UIKit

class CandidateMainProfileViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var closeButton: UIButton!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        self.navigationController?.navigationBar.topItem?.title = "My Profile";
        self.setNavigationBarItem(controllerName: "My Profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
         self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
        
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 71
        } else {
            return 40
            
        }
        
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
       
        return  9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        tableView.separatorColor = UIColor.clear
        
        if indexPath.row == 0 {
            
            var cell = CandidateProfileTableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! CandidateProfileTableViewCell
            
                cell.lblText.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                cell.lblText.text = "Aravind"
                cell.lblText.textAlignment = NSTextAlignment.center
         
                cell.lblAddress.font = UIFont(name:"HelveticaNeue", size: 16.0)
                cell.lblAddress.text = "North Sydney, NSW, 2000"
                cell.lblAddress.textAlignment = NSTextAlignment.center
          
            
            
            return cell;
        } else if indexPath.row == 8 {
            var cell = ThirdTableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell2")! as! ThirdTableViewCell
            
            return cell;
        } else {
        
            var cell = SecondTableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1")! as! SecondTableViewCell
            
            
            switch indexPath.row {
            case 1:
                cell.backgroundColor = UIColor(red: 201.0/255.0, green: 216.0/255.0, blue: 217.0/255.0, alpha: 1)
                cell.lblText.text = "About Me"
            case 2:
                cell.lblText.text = "Test Data"
                 cell.lblText.textAlignment = NSTextAlignment.left
                
            case 3:
                cell.backgroundColor = UIColor(red: 201.0/255.0, green: 216.0/255.0, blue: 217.0/255.0, alpha: 1)
                cell.lblText.text = "Skills"
            case 4:
                cell.lblText.text = "Desired Skills"
                cell.lblText.textAlignment = NSTextAlignment.left
            case 5:
                cell.backgroundColor = UIColor(red: 201.0/255.0, green: 216.0/255.0, blue: 217.0/255.0, alpha: 1)
                cell.lblText.text = "Year of Graduation"
            case 6:
                cell.lblText.text = "Graduation year"
                cell.lblText.textAlignment = NSTextAlignment.left
            
            case 7:
                cell.backgroundColor = UIColor(red: 201.0/255.0, green: 216.0/255.0, blue: 217.0/255.0, alpha: 1)
                cell.lblText.text = "Resume"
           
                
            default:
                break
            }
            
            
            return cell;
        }

    }
    


}

