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
    func remove(repository: Repository)
    func isBookmarked(repository: Repository) -> Bool
    func all() -> Results<Bookmark>
    func observe(didChange: @escaping (RealmCollectionChange<Results<Bookmark>>) -> Void) -> NotificationToken?
}

protocol BookmarkInteractorDelegate: class {
    
    func interactor(_ interactor: BookmarkUsecase, didUpdateBookmark repository: Repository, isBookmarked: Bool)
}

class BookmarkInteractor {
    
    weak var delegate: BookmarkInteractorDelegate?
    
    private let realm: Realm
    private lazy var objects: Results<Bookmark> = realm.objects(Bookmark.self)
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
}

extension BookmarkInteractor: BookmarkUsecase {
    
    func add(repository: Repository) {
        
        if let before = objects.first(where: { $0.repository.id == repository.id }) {
            
            try? realm.write {
                before.bookmarkAt = Date()
            }
        } else {
            try? realm.write {
                realm.add(Bookmark(repository: repository), update: false)
            }
        }
        
        delegate?.interactor(self, didUpdateBookmark: repository, isBookmarked: true)
    }
    
    func remove(repository: Repository) {
        guard let bookmark = objects.first(where: { $0.repository.id == repository.id }) else {
            return
        }
        
        try? realm.write {
            realm.delete(bookmark)
        }
        
        delegate?.interactor(self, didUpdateBookmark: repository, isBookmarked: false)
    }
    
    func isBookmarked(repository: Repository) -> Bool {
        guard objects.first(where: { $0.repository.id == repository.id }) != nil else {
            return false
        }
        return true
    }
    
    func all() -> Results<Bookmark> {
        return objects.sorted(byKeyPath: "bookmarkAt", ascending: false)
    }
    
    func observe(didChange: @escaping (RealmCollectionChange<Results<Bookmark>>) -> Void) -> NotificationToken? {
        
        return objects.observe { changes in
            didChange(changes)
        }
    }
}
