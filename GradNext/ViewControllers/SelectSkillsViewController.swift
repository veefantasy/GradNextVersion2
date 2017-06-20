//
//  ViewController.swift
//  searchBar
//
//  Created by Aravind on 5/15/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

import UIKit

class SelectSkillsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var selectedSkillsTableView: UITableView!
    @IBOutlet weak var skillsTableView: UITableView!
    var searchActive : Bool = false
    var data = [".Net","iOS","Android","Java","MainFrame","SAP","AnjularJS"]
    var filtered:[String] = []
    
    var selectedData:[String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func closeButtonClicked(_ sender: Any) {
         self.presentingViewController?.dismiss(animated: true, completion: nil)
         SharedManager.sharedInstance.selectedSkills.removeAll()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  tableView.delegate = self
       // tableView.dataSource = self
        searchBar.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        //  UIBarButtonItem  *barButtonAppearanceInSearchBar;
        var barButtonAppearanceInSearchBar = UIBarButtonItem()
        barButtonAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self])
        barButtonAppearanceInSearchBar.image = UIImage(named: "add")
        barButtonAppearanceInSearchBar.title = nil;
        selectedData.removeAll()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(filtered)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      print(searchBar.text!)
        
        let result = searchBar.text!
        
        if !result.isBlank{
        
        if selectedData.contains(where: {$0.caseInsensitiveCompare(searchBar.text!) == .orderedSame}) {
            print(true)  // true
        } else {
            
            selectedData.append(searchBar.text!)
        }
        selectedSkillsTableView.reloadData()
        
        print(filtered)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.skillsTableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = Int()
        if tableView.tag == 1 {
             count = 1
        } else {
            count = 1
            
        }
        return count
       
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
        var count = Int()
        if tableView.tag == 1 {
            if(searchActive) {
                count = filtered.count
            } else {
                count = data.count
            }
        } else {
            count = selectedData.count
        }
       return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
        var cell = SkillTableViewCell()

        cell = tableView.dequeueReusableCell(withIdentifier: "SkillTableViewCell")! as! SkillTableViewCell
        if(searchActive){
            cell.lblTitle?.text = filtered[indexPath.row]
        } else {
            cell.lblTitle?.text = data[indexPath.row];
        }
        cell.btnAdd.tag = indexPath.row;
        cell.selectionStyle = .none
        cell.btnAdd.addTarget(self, action: #selector(SelectSkillsViewController.addButton), for: .touchUpInside)
       
         return cell;
        } else {
            var cell = SelectedSkillsTableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "SelectedSkillsTableViewCell")! as! SelectedSkillsTableViewCell
            cell.lblTitle?.text = selectedData[indexPath.row]
            cell.btnClose.tag = indexPath.row;
            cell.selectionStyle = .none
            cell.btnClose.addTarget(self, action: #selector(SelectSkillsViewController.closeButton), for: .touchUpInside)
            return cell;
        }
        
    }
    
    
    func addButton(sender: UIButton){
        print(sender.tag )
        var selectedValue = String()
        if(searchActive){
           selectedValue = filtered[sender.tag]
        } else {
            selectedValue = data[sender.tag];
            print(data[sender.tag])
        }
        if selectedData.contains(where: {$0.caseInsensitiveCompare(selectedValue) == .orderedSame}) {
            print(true)  // true
        } else {
             selectedData.append(selectedValue)
            
        }
        selectedSkillsTableView.reloadData()
        let count = String(format: "%d", selectedData.count)
        lblTitle.text = "Selected Skills"+"("+count+")"
       
      }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        SharedManager.sharedInstance.selectedSkills = selectedData
    }
    func closeButton(sender: UIButton){
        selectedData.remove(at: sender.tag)
        selectedSkillsTableView.reloadData()
        let count = String(format: "%d", selectedData.count)
        lblTitle.text = "Selected Skills"+"("+count+")"
        
       
       
    }
}

extension String {
  
    var  isBlank:Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
    
}
