//
//  ExploreJobViewController.swift
//  GradNext
//
//  Created by Aravind on 6/12/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class ExploreJobViewController: UIViewController {
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblDesiredSkillsDescription: UILabel!

    @IBOutlet weak var aspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblApplicationCloseDate: UILabel!
    @IBOutlet weak var txtDesiredSkills: UITextView!
    @IBOutlet weak var lblJobTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let contentSize = self.txtDesiredSkills.sizeThatFits(self.txtDesiredSkills.bounds.size)
        var frame = self.txtDesiredSkills.frame
        frame.size.height = contentSize.height
        self.txtDesiredSkills.frame = frame
        
        aspectRatioConstraint = NSLayoutConstraint(item: self.txtDesiredSkills, attribute: .height, relatedBy: .equal, toItem: self.txtDesiredSkills, attribute: .width, multiplier: txtDesiredSkills.bounds.height/txtDesiredSkills.bounds.width, constant: 1)
        self.txtDesiredSkills.addConstraint(aspectRatioConstraint!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shortlistButtonClicked(_ sender: Any) {
        
        Utilities.gotoLogin()
    }
   
    @IBAction func applyButtonClicked(_ sender: Any) {
        Utilities.gotoLogin()

    }

    @IBAction func messageButtonClicked(_ sender: Any) {
        Utilities.gotoLogin()

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
