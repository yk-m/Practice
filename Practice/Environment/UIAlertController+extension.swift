//
//  UIAlertController+extension.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func singleBtnAlert(with title: String, message: String, completion: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) -> Void in
            if let completion = completion {
                completion()
            }
        })
        return alert
    }
}
