//
//  ApplicationViewController.swift
//  GradNext
//
//  Created by Muthu Kumar M on 5/13/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "My Application";
        self.view.backgroundColor = UIColor.white

        self.setNavigationBarItem(controllerName: "Application")

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
