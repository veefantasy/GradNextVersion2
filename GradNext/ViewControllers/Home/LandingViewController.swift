//
//  LandingViewController
//  GradNext
//
//  Created by Muthu Kumar on 09/06/16.
//  Copyright © 2017 Mk. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var SigninButton: UIButton!
    @IBOutlet weak var exploreButton: UIButton!
    
    @IBAction func exploreAction(_ sender: Any) {
        
       let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
       appDelegate.window?.rootViewController = appDelegate.ExploreMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        exploreButton.titleLabel?.textColor = UIColor.black
        exploreButton.backgroundColor = UIColor.white
        exploreButton.layer.borderWidth = 2.0
        exploreButton.layer.borderColor = UIColor.white.cgColor
        exploreButton.layer.cornerRadius = 3.0
        
        SigninButton.titleLabel?.textColor =  UIColor.white
        SigninButton.backgroundColor = UIColor.black
        SigninButton.layer.borderWidth = 2.0
        SigninButton.layer.borderColor = UIColor.black.cgColor
        SigninButton.layer.cornerRadius = 3.0
        
    }

  
    
    @IBAction func signinAction(_ sender: AnyObject) {
    
         print("signinAction")
        self.performSegue(withIdentifier: "signin", sender: self)
    }
    
    
    @IBAction func signupAction(_ sender: AnyObject) {
        print("signupAction")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
