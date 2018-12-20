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
        let repositoryInteractor = RepositoryInteractor()
        let searchHistoryInteractor = SearchHistoryInteractor()
        let presenter = ListViewPresenter(view: view,
                                          router: router,
                                          repositoryInteractor: repositoryInteractor,
                                          searchHistoryInteractor: searchHistoryInteractor)

        view.presenter = presenter
        repositoryInteractor.delegate = presenter
        searchHistoryInteractor.delegate = presenter

        return view
    }
}

extension ListRouter: ListWireframe {

    func showDetail(repository: Repository) {
        let view = DetailRouter.assembleModules(repository: repository)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
