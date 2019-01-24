//
//  Container.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

final class WriteTransaction {
    
    private let realm: Realm
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Persistable>(_ value: T, update: Bool) {
        realm.add(value.managedObject(), update: update)
    }
}

final class Container {
    
    private let realm: Realm
    
    convenience init() throws {
        try self.init(realm: Realm())
    }
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func retrieve<T: Persistable>(_ block: (Realm, Results<T.ManagedObject>) -> Results<T.ManagedObject>) -> [T] {
        let objects = realm.objects(T.object)
        let result = block(realm, objects)
        return Array(result).map { T.init(managedObject: $0) }
    }
    
    func retrieve<T: Persistable>(_ block: (Realm, Results<T.ManagedObject>) -> T.ManagedObject?) -> T? {
        let objects = realm.objects(T.object)
        if let result = block(realm, objects) {
            return T.init(managedObject: result)
        }
        return nil
    }
    
    func write(_ block: (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        
        try realm.write {
            try block(transaction)
        }
    }
}
