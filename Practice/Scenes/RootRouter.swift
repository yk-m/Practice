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
        let tabBarView = UITabBarController()

        let listView = ListRouter.assembleModules()
        listView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let bookmarkView = BookmarkListRouter.assembleModules()
        bookmarkView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        tabBarView.setViewControllers([listView, bookmarkView].map { view in
            let nav = UINavigationController(rootViewController: view)
            nav.navigationBar.prefersLargeTitles = true
            return nav
        }, animated: true)
        
        window.rootViewController = tabBarView
        window.tintColor = .main
        
        window.makeKeyAndVisible()
    }
}
