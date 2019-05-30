//
//  RepositorySearchQuery.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

class RepositorySearchQuery: Object, Queryable {
    
    @objc dynamic private(set) var keyword = ""
    @objc dynamic var searchAt = Date()

    convenience init(keyword: String) {
        self.init()
        self.keyword = keyword
    }
    
    func serialize() -> [URLQueryItem] {
        return [URLQueryItem(name: "q", value: keyword)]
    }
    
    override static func primaryKey() -> String? {
        return "keyword"
    }
}
