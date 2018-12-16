//
//  SearchRepositoriesQuery.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

struct RepositorySearchQuery {
    
    let keyword: String
}

extension RepositorySearchQuery: Queryable {
    
    func serialize() -> [URLQueryItem] {
        return [URLQueryItem(name: "q", value: keyword)]
    }
}

extension RepositorySearchQuery: Persistable {
    
    init(managedObject: RepositorySearchQueryObject) {
        keyword = managedObject.keyword
    }
    
    func managedObject() -> RepositorySearchQueryObject {
        let query = RepositorySearchQueryObject()
        query.keyword = keyword
        return query
    }
}
