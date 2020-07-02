//
//  ViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/14.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var issues: [[String: String?]] = []

    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var searchText: UITextField!
    
    var index = 0
    
        
    let refreshControl: UIRefreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        searchText.delegate = self
        getIssues()
        addToolBar(textField: searchText)
        
        
        refreshControl.addTarget(self, action: #selector(self.refreshReload(_:)), for: .valueChanged)
        homeTableView.refreshControl = refreshControl
        
        
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        self.homeTableView.reloadData()
        
    }*/
    
    
    @objc func refreshReload(_ sender: UIRefreshControl) {
        getIssues()
    }
    
    
    func getIssues(){        
        let homeUrl: String = "https://qiita.com/api/v2/items?page=1&per_page=100"
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request(homeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
                guard let homeObject = response.result.value else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    DispatchQueue.main.async {
                        if self.refreshControl.isRefreshing{
                            self.refreshControl.endRefreshing()
                        }
                    
                    //self.refreshControl.endRefreshing()
                    }
                    return
                }
            self.issues = [] //配列の要素をクリア
            let homeJson = JSON(homeObject)
                //print(homeJson)
                homeJson.forEach{ (_, json) in
                    let issue: [String: String?] = ["homeTitle": json["title"].string, "homelinkUrl": json["url"].string, "createdate": json["created_at"].string]
                    self.issues.append(issue)
                }
            MBProgressHUD.hide(for: self.view, animated: true)
      
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            //self.refreshControl.endRefreshing()
                //print(self.issues)
            
                self.homeTableView.reloadData()

        }
    }
    
    /*func reloadIssues(){
        let homeUrl: String = "https://qiita.com/api/v2/items?page=1&per_page=100"
        
        Alamofire.request(homeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
                guard let homeObject = response.result.value else{
                    self.refreshControl.endRefreshing()
                    return
                }
                let homeJson = JSON(homeObject)
                print(homeJson)
                homeJson.forEach{ (_, json) in
                    let issue: [String: String?] = ["homeTitle": json["title"].string, "homelinkUrl": json["url"].string]
                    self.issues.append(issue)
                }
            self.refreshControl.endRefreshing()
                //print(self.issues)
            self.homeTableView.reloadData()
        }
    }*/

    // MARK: - Table view data source

    /*func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        let issue = issues[indexPath.row]
        cell.textLabel?.text = issue["homeTitle"]!
        

        let dateString = createDate(issue["createdate"]!!)
        cell.detailTextLabel?.text = dateString
            
        return cell
    }
    
    

    func createDate(_ dateStr : String) -> String
    {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "yyyy/MM/dd"
            let str = formatter.string(from: date)
            return str
        }
        return dateStr
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeTableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        self.performSegue(withIdentifier: "goHomeView", sender: self)
        
        
    }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let keyword = textField.text{
            print(keyword)
            self.performSegue(withIdentifier: "goList", sender: self)
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goList" {
            let listcontroller = segue.destination as! ListTableViewController
            listcontroller.keyword = searchText.text!
        }else if segue.identifier == "goHomeView" {            
                let issue = issues[index]
                let homewebviewcontroller = segue.destination as! HomeWebViewController
                homewebviewcontroller.homeLink = issue["homelinkUrl"]!
                //print(issue["homelinkUrl"]!!)
            
        }
    }
    
    func addToolBar(textField: UITextField){
          let toolBar = UIToolbar()
          toolBar.barStyle = UIBarStyle.default
          toolBar.isTranslucent = true
          toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "閉じる", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressed))

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          toolBar.setItems([ spaceButton, doneButton], animated: false)
          toolBar.isUserInteractionEnabled = true
          toolBar.sizeToFit()

          textField.delegate = self
          textField.inputAccessoryView = toolBar
      }
    @objc func donePressed(){
          view.endEditing(true)
      }
        

    
}

