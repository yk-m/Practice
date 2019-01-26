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
    func filter(text: String)
}

protocol SearchHistoryInteractorDelegate: class {
    
    func interactor(_ interactor: SearchHistoryUsecase, didUpdate queries: [RepositorySearchQuery])
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveHistory queries: [RepositorySearchQuery])
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveLatestRecord query: RepositorySearchQuery?)
}

class SearchHistoryInteractor {
    
    weak var delegate: SearchHistoryInteractorDelegate?
    
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
}

extension SearchHistoryInteractor: SearchHistoryUsecase {
    
    func add(query: RepositorySearchQuery) {
        query.searchAt = Date()
        
        if let before = realm
            .objects(RepositorySearchQuery.self)
            .first(where: { $0.keyword == query.keyword }) {
            
            try? realm.write {
                before.searchAt = Date()
            }
        } else {
            try? realm.write {
                realm.add(query, update: false)
            }
        }
        
        let queries = realm
            .objects(RepositorySearchQuery.self)
            .sorted(byKeyPath: "searchAt", ascending: false)
        delegate?.interactor(self, didUpdate: Array(queries))
    }
    
    func retrieve() {
        let queries = realm
            .objects(RepositorySearchQuery.self)
            .sorted(byKeyPath: "searchAt", ascending: false)
        delegate?.interactor(self, didRetrieveHistory: Array(queries))
    }
    
    func retrieveLatestRecord() {
        let query = realm
            .objects(RepositorySearchQuery.self)
            .sorted(byKeyPath: "searchAt", ascending: false)
            .first
        delegate?.interactor(self, didRetrieveLatestRecord: query)
    }
    
    func filter(text: String) {
        guard !text.isEmpty else {
            retrieve()
            return
        }
        
        let queries = realm
            .objects(RepositorySearchQuery.self)
            .filter("keyword contains %@", text.realmEscaped)
            .filter("keyword != %@", text.realmEscaped)
            .sorted(byKeyPath: "searchAt", ascending: false)
        
        delegate?.interactor(self, didRetrieveHistory: Array(queries))
    }
}
