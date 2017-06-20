//
//  CompanyMainProfileViewController.swift
//  GradNext
//
//  Created by Aravind on 6/18/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class CompanyMainProfileViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Company Profile"
        self.navigationController?.navigationBar.topItem?.title = "Company Profile";
        self.setNavigationBarItem(controllerName: "Company Profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func addbuttonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompanyAddUserViewController") as! CompanyAddUserViewController
        self.present(vc, animated: true, completion: nil)
        
    }

    @IBAction func postJobButtonClicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostJobViewController") as! PostJobViewController
        self.present(vc, animated: true, completion: nil)
    }
    //MARK: Tableview delegates and datasources
    func numberOfSections(in tableView: UITableView) -> Int {
         if tableView.tag == 0 {
             return 1
         } else {
            
             return 1
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
        if tableView.tag == 0 {
            return 1
        } else {
            
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView.tag == 0 {
            let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "CompanyMainProfileJobsTableViewCell") as! CompanyMainProfileJobsTableViewCell
            
            return notificationsCell
            
        } else {
            let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "CompanyMainProfileAdminTableViewCell") as! CompanyMainProfileAdminTableViewCell
            
            return notificationsCell
            
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CandidateMainProfileViewController") as! CandidateMainProfileViewController
        self.present(vc, animated: true, completion: nil)
        
        
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
