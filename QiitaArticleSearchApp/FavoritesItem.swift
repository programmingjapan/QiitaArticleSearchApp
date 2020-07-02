//
//  FavoritesItem.swift
//  QiitaArticleSearchApp
//
//  Created by Hideto Kamei on 2020/05/17.
//  Copyright © 2020 Hideto Kamei. All rights reserved.
//

import Foundation
import RealmSwift

class FavoritesItem: Object {
    @objc dynamic var favoritesTitle = ""
    @objc dynamic var favoritesUrl = ""
}
