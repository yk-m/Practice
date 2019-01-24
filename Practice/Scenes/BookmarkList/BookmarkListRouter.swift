//
//  BookmarkListRouter.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import UIKit

class BookmarkListRouter {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = BookmarkListViewController()
        let router = BookmarkListRouter(viewController: view)
        let presenter = BookmarkListViewPresenter(view: view, router: router)

        view.presenter = presenter

        return view
    }
}

extension BookmarkListRouter: BookmarkListWireframe {

    func showDetail(repository: Repository) {
        let view = DetailRouter.assembleModules(repository: repository)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
