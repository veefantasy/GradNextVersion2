//
//  ExploreCompanyViewController.swift
//  GradNext
//
//  Created by Aravind on 6/17/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class ExploreCompanyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var companyInfoTextView: UITextView!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companySubLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var LogoButton: UIButton!
    
    var imageurl = ""
    var companyName = ""
    var companyDetail = ""
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(imageurl)
        print(companyName)
        print(companyDetail)
        print(address)
        
        LogoButton.sd_setImage(with: URL(string: "http://service.gradnext.com\(self.imageurl)" ) , for: UIControlState.normal)
       
//        let url = URL(string: "http://service.gradnext.com\(imageurl)])" )
//        print(url)

        
//        let data = NSData.init(contentsOf: url!)
        
//        print(data)
        
//        let image = UIImage(data: data as! Data)
        
//        LogoButton.setImage(image, for: UIControlState.normal)
        companyInfoTextView.text    = companyDetail
        companyLabel.text    = companyName
//imageurl
        companySubLabel.text    = companyName
        companyAddressLabel.text    = address


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func loadMoreButton(_ sender: Any) {
    }

    //MARK: Tableview delegates and datasources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
            return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "ExploreCompanyDetailsTableViewCell") as! ExploreCompanyDetailsTableViewCell
               return notificationsCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
