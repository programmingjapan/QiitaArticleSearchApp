//
//  WebViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/15.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift
//import MBProgressHUD

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var articleTitle: String!
    var articleLink: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        if let articleUrl = URL(string: articleLink){
            let request = URLRequest(url: articleUrl)
            self.webView.load(request)
        }
    }
    
    //時間が長いのでインジケータをやめた。
    /*func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }*/
        
    @IBAction func saveButtonAction(_ sender: Any) {
    
        
        let alertController = UIAlertController(title: "お気に入りに保存", message: "この記事をお気に入りに保存しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {(action: UIAlertAction) in
            let favoritesItem = FavoritesItem()
            favoritesItem.favoritesTitle = self.articleTitle
            favoritesItem.favoritesUrl = self.articleLink
            let realm = try! Realm()
            try! realm.write {
                realm.add(favoritesItem)
                
            }
        }
        alertController.addAction(okAction)
        
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
}
