//
//  CompanyMainProfileViewController.swift
//  GradNext
//
//  Created by Aravind on 6/18/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class CompanyMainProfileViewController: UIViewController {

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
