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

    init(view: ListView,
         router: ListWireframe,
         repositoryInteractor: RepositoryUsecase) {
        self.router = router
        self.view = view
        self.repositoryInteractor = repositoryInteractor
    }
}

extension ListViewPresenter: ListViewPresentable {
    
    func didSelectRow(repository: Repository) {
        router.showDetail(repository: repository)
    }
    
    func set(searchText: String?) {
        guard let searchText = searchText,
            !searchText.isEmpty else {
            view?.set(repositories: [])
            return
        }
        
        let query = RepositorySearchQuery(keyword: searchText)
        repositoryInteractor.retrieve(query: query)
    }
}

extension ListViewPresenter: RepositoryInteractorDelegate {
    
    func interactor(_ interactor: RepositoryUsecase, didRetrieveRepositories repositories: [Repository]) {
        view?.set(repositories: repositories)
        
        if repositories.count == 0 {
            view?.presentAlert(title: "見つかりませんでした", message: "キーワードを変えてお試しください。")
        }
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
