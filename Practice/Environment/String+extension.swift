//
//  String+extension.swift
//  Practice
//
//  Created by yuka on 2018/12/17.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation

extension String {
    
    public var realmEscaped: String {
        let reps = [
            "\\" : "\\\\",
            "'"  : "\\'",
            ]
        var ret = self
        for rep in reps {
            ret = self.replacingOccurrences(of: rep.0, with: rep.1)
        }
        return ret
    }
}
