//
//  UIImageView+extension.swift
//  Practice
//
//  Created by yuka on 2019/01/25.
//  Copyright © 2019 Yuka Matsuo. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        self.kf.setImage(with: url)
    }
}
