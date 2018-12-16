//
//  Persistable.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    
    associatedtype ManagedObject: RealmSwift.Object
    
    static var object: ManagedObject.Type { get }
    
    init(managedObject: ManagedObject)
    
    func managedObject() -> ManagedObject
}
