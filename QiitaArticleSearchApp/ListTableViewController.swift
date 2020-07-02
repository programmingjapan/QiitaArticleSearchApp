//
//  ListTableViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/14.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ListTableViewController: UITableViewController {
    
    var keyword = ""
    var articles: [[String: String?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArticles()
    }
    
    func getArticles(){
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let url: String = "https://qiita.com/api/v2/items?page=1&per_page=100&query=tag%3A\(keyword_encode)"
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
                guard let object = response.result.value else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    return
                }
                let json = JSON(object)
                //print(json)
                json.forEach{ (_, json) in
                    let article: [String: String?] = ["title": json["title"].string, "linkUrl": json["url"].string]
                    self.articles.append(article)
                }
            MBProgressHUD.hide(for: self.view, animated: true)
                //print(self.articles)
                self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let article = articles[indexPath.row]
            let webviewcontroller = segue.destination as! WebViewController
            webviewcontroller.articleTitle = article["title"]!
            webviewcontroller.articleLink = article["linkUrl"]!
            
            //print(article["title"]!!)
            //print(article["linkUrl"]!!)
        }

    }
    

    

}
