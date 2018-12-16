//
//  SearchHistoryInteractor.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

protocol SearchHistoryUsecase {
    
    func add(query: RepositorySearchQuery)
    func retrieve()
    func retrieveLatestRecord()
}

protocol SearchHistoryInteractorDelegate: class {
    
    func interactor(_ interactor: SearchHistoryUsecase, didUpdate queries: [RepositorySearchQuery])
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveHistory queries: [RepositorySearchQuery])
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveLatestRecord query: RepositorySearchQuery?)
}

class SearchHistoryInteractor {
    
    weak var delegate: SearchHistoryInteractorDelegate?
    
    let container: Container
    
    init(container: Container = try! Container()) {
        self.container = container
    }
}

extension SearchHistoryInteractor: SearchHistoryUsecase {
    
    func add(query: RepositorySearchQuery) {
        let queries: [RepositorySearchQuery] = container.retrieve { realm, objects in
            if let searchQuery = objects.filter("keyword = %@", query.keyword).first {
                try? realm.write {
                    searchQuery.date = Date()
                }
            } else {
                try? realm.write {
                    realm.add(query.managedObject(), update: false)
                }
            }
            
            return objects.sorted(byKeyPath: "date", ascending: false)
        }
        
        delegate?.interactor(self, didUpdate: queries)
    }
    
    func retrieve() {
        let queries: [RepositorySearchQuery] = container.retrieve { _, objects in
            return objects.sorted(byKeyPath: "date", ascending: false)
        }
        
        delegate?.interactor(self, didRetrieveHistory: queries)
    }
    
    func retrieveLatestRecord() {
        let query: RepositorySearchQuery? = container.retrieve { _, objects in
            return objects.sorted(byKeyPath: "date", ascending: false).first
        }
        
        delegate?.interactor(self, didRetrieveLatestRecord: query)
    }
}
