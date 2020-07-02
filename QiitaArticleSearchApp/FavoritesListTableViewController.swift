//
//  FavoritesListTableViewController.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/17.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesListTableViewController: UITableViewController {
    
    var realm: Realm!
    var favoritesItems: Results<FavoritesItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        
        favoritesItems = realm.objects(FavoritesItem.self).sorted(byKeyPath: "favoritesTitle", ascending: true)
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoritesItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
        let favoritesitem = favoritesItems[indexPath.row]
        cell.textLabel?.text = favoritesitem.favoritesTitle
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let favoritesitem = favoritesItems[indexPath.row]
            let favoriteswebviewcontroller = segue.destination as! FavoritesWebViewController
            favoriteswebviewcontroller.favoritesLink = favoritesitem["favoritesUrl"]! as? String
            
            print(favoritesitem["favoritesUrl"]!)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(favoritesItems[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        favoritesItems = realm.objects(FavoritesItem.self).sorted(byKeyPath: "favoritesTitle", ascending: true)
        tableView.reloadData()
        
    }


}
