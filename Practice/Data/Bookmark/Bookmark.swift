//
//  Bookmark.swift
//  Practice
//
//  Created by sci01725 on 2019/01/24.
//  Copyright © 2019 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    
    @objc dynamic var bookmarkAt = Date()
    @objc dynamic var repository: Repository!
    
    convenience init(repository: Repository) {
        self.init()
        self.repository = repository
    }
}
