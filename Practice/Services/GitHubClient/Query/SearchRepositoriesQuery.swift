//
//  SearchRepositoriesQuery.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation

struct SearchRepositoriesQuery {
    
    let keyword: String
}

extension SearchRepositoriesQuery: Queryable {
    
    func serialize() -> [URLQueryItem] {
        return [URLQueryItem(name: "q", value: keyword)]
    }
}
