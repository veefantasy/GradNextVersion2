
//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem(controllerName : String) {
     
        
        if UserDefaults.standard.object(forKey: "UserOption") != nil{
            if ((UserDefaults.standard.value(forKey: "UserOption") as! String) == "CAND")
            {
                
              
//                
//                if(controllerName ==  "Home" || controllerName == "My Profile" || controllerName == "My Shortlist"||controllerName == "Manage Job"||controllerName == "Post Job"||controllerName == "Search Talent")
//                {
//                    self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
//                }
//                else
//                {
//                    self.addRightBarButtonWithTwoImage(UIImage(named: "ic_notifications_black_24dp")!, _HomeImage: UIImage(named: "home")!)
//                }
                
                switch controllerName {
                case "Home":
                    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
                    self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
                case "My Profile":
                    self.addMyProfileHomeButton(UIImage(named: "ic_menu_black_24dp")!)
                    self.addMyProfileEditButton(UIImage(named: "edit")!)
                case "Notifications":
                    self.addMyProfileHomeButton(UIImage(named: "ic_menu_black_24dp")!)
                  //  self.addMyProfileEditButton(UIImage(named: "edit")!)
                default:
                    break
                }
                
                
                
            } else {
                
                
                
                
                switch controllerName {
                
                case "Company Profile":
                     self.addLeftBarButton(UIImage(named: "ic_menu_black_24dp")!)
                    self.companyEditProfilenavigationItem(UIImage(named: "edit")!)
                case "Search Talent":
                    self.addLeftBarButton(UIImage(named: "ic_menu_black_24dp")!)
                  
                default:
                    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
                    self.companyRightnavigationItem(UIImage(named: "add")!)

               }
            
            }
            
            
            //  self.slideMenuController()?.removeLeftGestures()
            //  self.slideMenuController()?.removeRightGestures()
            self.slideMenuController()?.addLeftGestures()
            // self.slideMenuController()?.addRightGestures()
            // exist
        }
        else {
            // not exist
        }
        
        
        
        
     
        
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
   
    
    
    
}
