//
//  RootRouter.swift
//  Practice
//
//  Created by Yuka Matsuo on 16/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import UIKit

class RootRouter {
    
    private init() {}
    
    static func showFirstView(window: UIWindow) {
        let firstView = ListRouter.assembleModules()
        let navigationController = UINavigationController(rootViewController: firstView)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
