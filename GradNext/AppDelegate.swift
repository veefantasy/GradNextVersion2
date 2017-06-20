//
//  AppDelegate.swift
//  GradNext
//
//  Created by Muthu Kumar on 09/06/16.
//  Copyright © 2017 Mk. All rights reserved.
//123123
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let userOption = UserDefaults.standard.value(forKey: "UserOption")
        
        if  let user = userOption
        {
            if !(user as! String).isEmpty {
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

            if (userOption as! String == "CAND")
             {
                appDelegate.window?.rootViewController = createMenuView()
            }
             else
             {
                appDelegate.window?.rootViewController = companyMenuView()
            }
            }
        }
        else
        {
            

            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController =  LandingView()
            
        }
        

        
        // Override point for customization after application launch.
        return true
    }
    
    public func LandingView()->UIViewController
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LandingViewController") as! LandingViewController
        
        return leftViewController
 
    }
    
    
    
    public func ExploreMenu()->UIViewController
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let exploreViewController = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        
        let tabBar :UITabBarController = UITabBarController()
        let nvc: UINavigationController = UINavigationController()
        nvc.viewControllers = [exploreViewController]
        
        
        let eMyApplicaitonViewController = storyboard.instantiateViewController(withIdentifier: "EMyApplicaitonViewController") as! EMyApplicaitonViewController
        let eMyApp: UINavigationController = UINavigationController()
        eMyApp.viewControllers = [eMyApplicaitonViewController]
        
        nvc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named:""), selectedImage: UIImage(named:""))
        
        eMyApp.tabBarItem = UITabBarItem(title: "My Application", image: UIImage(named:""), selectedImage: UIImage(named:""))
        
        let eMyShortListViewController = storyboard.instantiateViewController(withIdentifier: "EMyShortListViewController") as! EMyShortListViewController
        let eMyShort: UINavigationController = UINavigationController()
        eMyShort.viewControllers = [eMyShortListViewController]

        eMyShort.tabBarItem = UITabBarItem(title: "Shortlist", image: UIImage(named:""), selectedImage: UIImage(named:""))

        tabBar.viewControllers  = [exploreViewController,eMyApp,eMyShort]
        
        UITabBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x39B7ED)
        UITabBar.appearance().selectedImageTintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)
        
        UINavigationBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)

        return tabBar
        
    }
    
    public func companyMenuView()-> SlideMenuController{
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewcontroller") as! LeftViewController
        let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewcontroller") as! RightViewController
        
        let companyHomeViewController = storyboard.instantiateViewController(withIdentifier: "CompanyHomeViewController") as! CompanyHomeViewController
        let postJob: UINavigationController = UINavigationController()
        postJob.viewControllers = [companyHomeViewController]
        
        let userlistViewController = storyboard.instantiateViewController(withIdentifier: "CompanyMainProfileViewController") as! CompanyMainProfileViewController
        let manageJob: UINavigationController = UINavigationController()
        manageJob.viewControllers = [userlistViewController]
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "CompSearchTalentViewController") as! SearchTalentViewController
        let nvc: UINavigationController = UINavigationController()
        nvc.viewControllers = [mainViewController]
        
        
        let tabBar :UITabBarController = UITabBarController()
        
        postJob.tabBarItem = UITabBarItem(title: "Post Job", image: UIImage(named:""), selectedImage: UIImage(named:""))
        
        manageJob.tabBarItem = UITabBarItem(title: "Manage Job", image: UIImage(named:""), selectedImage: UIImage(named:""))
        
        
        nvc.tabBarItem = UITabBarItem(title: "Search Talent", image: UIImage(named:""), selectedImage: UIImage(named:""))
        
        tabBar.viewControllers  = [postJob,manageJob,nvc]
        
        UITabBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x39B7ED)
        UITabBar.appearance().selectedImageTintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)
        
        UINavigationBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)
        
        let slideMenuController = SlideMenuController(mainViewController: tabBar, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        
        return slideMenuController
        
    }
    
    
    public func createMenuView()-> SlideMenuController{
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewcontroller") as! LeftViewController
        let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewcontroller") as! RightViewController
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! HomeViewController
        let nvc: UINavigationController = UINavigationController()
        nvc.viewControllers = [mainViewController]
        
        
        let applicationViewController = storyboard.instantiateViewController(withIdentifier: "ApplicationViewController") as! ApplicationViewController
        let channel: UINavigationController = UINavigationController()
        channel.viewControllers = [applicationViewController]
        
        let userlistViewController = storyboard.instantiateViewController(withIdentifier: "userlistViewController") as! UserShortListViewController
        let shortList: UINavigationController = UINavigationController()
        shortList.viewControllers = [userlistViewController]
        
        
        let tabBar :UITabBarController = UITabBarController()
        
        nvc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"Home_Tab"), selectedImage: UIImage(named:"Home_TabSelected"))
        
        channel.tabBarItem = UITabBarItem(title: "My Applications", image: UIImage(named:"myapp_tab"), selectedImage: UIImage(named:"myapp_tab"))
        
        
        shortList.tabBarItem = UITabBarItem(title: "My Shortlist", image: UIImage(named:"profile_tab"), selectedImage: UIImage(named:"profile_tab"))
        
        
        tabBar.viewControllers  = [nvc,channel,shortList]
        UITabBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x39B7ED)
        UITabBar.appearance().selectedImageTintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)
        
        UINavigationBar.appearance().tintColor = Utilities.UIColorFromRGB(rgbValue: 0x242424)
        
        let slideMenuController = SlideMenuController(mainViewController: tabBar, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        
        return slideMenuController
        
    }
    
    public func createMyProfileView(){
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewcontroller") as! LeftViewController
        let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewcontroller") as! RightViewController
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "CandidateMainProfileViewController") as! CandidateMainProfileViewController
        let nvc: UINavigationController = UINavigationController()
        nvc.viewControllers = [mainViewController]
        
        
       
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        slideMenuController.reloadInputViews()
       // return slideMenuController
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

