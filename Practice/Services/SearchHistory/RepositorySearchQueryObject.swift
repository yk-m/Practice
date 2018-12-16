//
//  RepositorySearchQueryObject.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

class RepositorySearchQueryObject: Object {
    
    @objc dynamic var date = Date()
    @objc dynamic var keyword = ""
}
