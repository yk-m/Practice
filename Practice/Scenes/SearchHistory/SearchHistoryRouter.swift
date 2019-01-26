//
//  SearchHistoryRouter.swift
//  Practice
//
//  Created by Yuka Matsuo on 25/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import UIKit

protocol SearchHisotryDelegate: class {
    
    func searchHistory(_ searchHistory: SearchHistoryRouter, didSelect searchText: String?)
}

class SearchHistoryRouter {
    
    weak var delegate: SearchHisotryDelegate?

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(delegate: SearchHisotryDelegate?) -> SearchHistoryView {
        let view = SearchHistoryViewController()
        let router = SearchHistoryRouter(viewController: view)
        let searchHistoryInteractor = SearchHistoryInteractor()
        let presenter = SearchHistoryViewPresenter(view: view,
                                                   router: router,
                                                   searchHistoryInteractor: searchHistoryInteractor)

        view.presenter = presenter
        
        router.delegate = delegate
        searchHistoryInteractor.delegate = presenter
        
        return view
    }
}

extension SearchHistoryRouter: SearchHistoryWireframe {

    func select(searchText: String?) {
        delegate?.searchHistory(self, didSelect: searchText)
    }
}
