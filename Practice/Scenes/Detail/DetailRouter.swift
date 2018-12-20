//
//  DetailRouter.swift
//  Practice
//
//  Created by Yuka Matsuo on 20/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import UIKit

class DetailRouter {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(repository: Repository) -> UIViewController {
        let view = DetailViewController()
        let router = DetailRouter(viewController: view)
        let presenter = DetailViewPresenter(view: view, router: router, repository: repository)

        view.presenter = presenter

        return view
    }
}

extension DetailRouter: DetailWireframe {

}
