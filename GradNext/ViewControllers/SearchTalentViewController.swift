//
//  SearchTalentViewController.swift
//  GradNext
//
//  Created by Aravind on 6/17/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class SearchTalentViewController: UIViewController, UITextFieldDelegate ,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var btnGo: UIButton!

    @IBOutlet weak var txtSkills: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Talent"
        self.navigationController?.navigationBar.topItem?.title = "Search Talent";
        self.setNavigationBarItem(controllerName: "Search Talent")

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    Utilities.setTextFieldCornerRadius(forTextField: txtSkills, withRadius: 3.0, withBorderColor:  UIColor.gray)
    
        btnGo.layer.cornerRadius = 3.0
        
        txtSkills.setLeftPaddingPoints(10)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.blue)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        Utilities.setTextFieldCornerRadius(forTextField: textField, withRadius: 3.0, withBorderColor: UIColor.gray)
        
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
        return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "SearchTalentTableViewCell") as! SearchTalentTableViewCell
        
            return notificationsCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
