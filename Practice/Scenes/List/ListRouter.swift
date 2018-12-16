//
//  ListRouter.swift
//  Practice
//
//  Created by Yuka Matsuo on 16/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import UIKit

class ListRouter {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = ListViewController()
        let router = ListRouter(viewController: view)
        let presenter = ListViewPresenter(view: view, router: router)

        view.presenter = presenter

        return view
    }
}

extension ListRouter: ListWireframe {

}
