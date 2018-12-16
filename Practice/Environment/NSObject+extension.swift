//
//  NSObject+extension.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation

protocol ClassName {
    
    static var className: String { get }
    var className: String { get }
}

extension ClassName {
    
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassName {}
