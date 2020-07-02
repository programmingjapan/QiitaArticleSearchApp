//
//  HomeWebViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/30.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import WebKit
//import MBProgressHUD

class HomeWebViewController: UIViewController, WKNavigationDelegate {
    
    var homeLink: String!
    
    @IBOutlet weak var homeWebView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        homeWebView.navigationDelegate = self
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        if let homeIssueUrl = URL(string: homeLink){
            let request = URLRequest(url: homeIssueUrl)
            self.homeWebView.load(request)
        }
    }
    
    //時間が長いのでインジケータをやめた。
    /*func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }*/
    
    /*override func viewWillAppear(_ animated: Bool) {
        if let homeIssueUrl = URL(string: homeLink){
            let request = URLRequest(url: homeIssueUrl)
            self.homeWebView.load(request)
        }
        
    }*/

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
