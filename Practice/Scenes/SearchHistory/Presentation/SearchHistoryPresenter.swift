//
//  SearchHistoryPresenter.swift
//  Practice
//
//  Created by Yuka Matsuo on 25/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import Foundation

class SearchHistoryViewPresenter {

    private weak var view: SearchHistoryView?
    private let router: SearchHistoryWireframe
    private let searchHistoryInteractor: SearchHistoryUsecase
    
    init(view: SearchHistoryView,
         router: SearchHistoryWireframe,
         searchHistoryInteractor: SearchHistoryUsecase) {
        self.view = view
        self.router = router
        self.searchHistoryInteractor = searchHistoryInteractor
    }
    
    private var searchText: String? {
        didSet {
            router.select(searchText: searchText)
            
            guard let searchText = searchText else {
                return
            }
            let query = RepositorySearchQuery(keyword: searchText)
            searchHistoryInteractor.add(query: query)
            view?.set(searchText: query.keyword)
        }
    }
}

extension SearchHistoryViewPresenter: SearchHistoryViewPresentable {
    
    func listViewDidLoad() {
        searchHistoryInteractor.retrieveLatestRecord()
    }
    
    func willPresentSearchController() {
        searchHistoryInteractor.retrieve()
    }
    
    func didSelectRow(query: RepositorySearchQuery) {
        searchText = query.keyword
    }
    
    func updateSearchResults(searchText: String?) {
        searchHistoryInteractor.filter(text: searchText ?? "")
    }
    
    func searchBarSearchButtonClicked(searchText: String?) {
        self.searchText = searchText
    }
    
    func searchBarCancelButtonClicked() {
        searchText = nil
    }
}

extension SearchHistoryViewPresenter: SearchHistoryInteractorDelegate {
    
    func interactor(_ interactor: SearchHistoryUsecase, didUpdate queries: [RepositorySearchQuery]) {
        view?.set(queries: queries)
    }
    
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveHistory queries: [RepositorySearchQuery]) {
        view?.set(queries: queries)
    }
    
    func interactor(_ interactor: SearchHistoryUsecase, didRetrieveLatestRecord query: RepositorySearchQuery?) {
        guard let searchText = query?.keyword else {
            return
        }
        
        self.searchText = searchText
    }
}

