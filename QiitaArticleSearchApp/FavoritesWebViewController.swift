//
//  FavoritesWebViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/17.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import WebKit
//import MBProgressHUD

class FavoritesWebViewController: UIViewController, WKNavigationDelegate {

    var favoritesLink: String!
    
    
    @IBOutlet weak var favoritesWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesWebView.navigationDelegate = self
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        if let favoritesIssueUrl = URL(string: favoritesLink){
            let request = URLRequest(url: favoritesIssueUrl)
            self.favoritesWebView.load(request)
        }
    }
    
    //時間が長いのでインジケータをやめた。
    /*func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
