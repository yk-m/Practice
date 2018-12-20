//
//  ListPresenter.swift
//  Practice
//
//  Created by Yuka Matsuo on 16/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import Foundation

class ListViewPresenter {

    private weak var view: ListView?
    private let router: ListWireframe
    private let repositoryInteractor: RepositoryUsecase
    private let searchHistoryInteractor: SearchHistoryUsecase
    
    private var searchText = "" {
        didSet {
            view?.set(searchText: searchText)
            
            let query = RepositorySearchQuery(keyword: searchText)
            searchHistoryInteractor.add(query: query)
            repositoryInteractor.retrieve(query: query)
        }
    }

    init(view: ListView,
         router: ListWireframe,
         repositoryInteractor: RepositoryUsecase,
         searchHistoryInteractor: SearchHistoryUsecase) {
        self.router = router
        self.view = view
        self.repositoryInteractor = repositoryInteractor
        self.searchHistoryInteractor = searchHistoryInteractor
    }
}

extension ListViewPresenter: ListViewPresentable {

    func viewDidLoad() {
        searchHistoryInteractor.retrieveLatestRecord()
    }
    
    func willPresentSearchController() {
        searchHistoryInteractor.retrieve()
    }
    
    func didSelectRow(repository: Repository) {
        router.showDetail(repository: repository)
    }
    
    func set(searchText: String) {
        self.searchText = searchText
    }
    
    func filter(text: String) {
        searchHistoryInteractor.filter(text: text)
    }
}

extension ListViewPresenter: RepositoryInteractorDelegate {
    
    func interactor(_ interactor: RepositoryUsecase, didRetrieveRepositories repositories: [Repository]) {
        view?.set(repositories: repositories)
    }
    
    func interactor(_ interactor: RepositoryUsecase, didFailWithError error: GitHubClientError) {
        switch error {
        case .connectionError(_):
            view?.presentAlert(title: "通信に失敗しました", message: "ネットワーク接続を確認してください。")
        case .responseParseError(_):
            view?.presentAlert(title: "ただいま混み合っています", message: "時間をあけて再度お試しください。")
        case .apiError(let error):
            view?.presentAlert(title: "エラーが発生しました", message: error.message)
        }
    }
}

extension ListViewPresenter: SearchHistoryInteractorDelegate {
    
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
