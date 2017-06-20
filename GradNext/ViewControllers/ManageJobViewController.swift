//
//  ManageJobViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 5/21/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class ManageJobViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.title = "Manage Job"
        self.navigationController?.navigationBar.topItem?.title = "Manage Job";
        self.setNavigationBarItem(controllerName: "Manage Job")

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
