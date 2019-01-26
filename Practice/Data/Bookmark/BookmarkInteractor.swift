//
//  BookmarkInteractor.swift
//  Practice
//
//  Created by sci01725 on 2019/01/24.
//  Copyright © 2019 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

protocol BookmarkUsecase {
    
    func add(repository: Repository)
    func retrieve()
}

protocol BookmarkInteractorDelegate: class {
    
    func interactor(_ interactor: BookmarkUsecase, didBookmark repository: Repository)
}

class BookmarkInteractor {
    
    weak var delegate: BookmarkInteractorDelegate?
    
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
}

extension BookmarkInteractor: BookmarkUsecase {
    
    func add(repository: Repository) {
//        container.write { transaction in
//            transaction.add(repository, update: true)
//        }
//        let queries: [RepositorySearchQuery] = container.retrieve { realm, objects in
//            if let searchQuery = objects.filter("keyword = %@", query.keyword).first {
//                try? realm.write {
//                    searchQuery.date = Date()
//                }
//            } else {
//                try? realm.write {
//                    realm.add(query.managedObject(), update: false)
//                }
//            }
//
//            return objects.sorted(byKeyPath: "date", ascending: false)
//        }
//
//        delegate?.interactor(self, didUpdate: queries)
    }
    
    func retrieve() {
//        let queries: [RepositorySearchQuery] = container.retrieve { _, objects in
//            return objects.sorted(byKeyPath: "date", ascending: false)
//        }
//        
//        delegate?.interactor(self, didRetrieveHistory: queries)
    }
}
