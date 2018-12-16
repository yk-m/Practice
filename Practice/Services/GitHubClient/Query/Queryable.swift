//
//  Queryable.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation

protocol Queryable: Decodable {
    
    func serialize() -> [URLQueryItem]
}
