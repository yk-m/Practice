//
//  RepositoryInteractor.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import Foundation

protocol RepositoryUsecase {
    
    func retrieve(keyword: String)
    func retrieve(query: RepositorySearchQuery)
}

protocol RepositoryInteractorDelegate: class {
    
    func interactor(_ interactor: RepositoryUsecase, didRetrieveRepositories repositories: [Repository])
    func interactor(_ interactor: RepositoryUsecase, didFailWithError error: GitHubClientError)
}

class RepositoryInteractor {
    
    weak var delegate: RepositoryInteractorDelegate?
    
    private let client: GitHubClient
    
    init(client: GitHubClient = GitHubClient()) {
        self.client = client
    }
}

extension RepositoryInteractor: RepositoryUsecase {
    
    func retrieve(keyword: String) {
        let query = RepositorySearchQuery(keyword: keyword)
        retrieve(query: query)
    }
    
    func retrieve(query: RepositorySearchQuery) {
        let request = GitHubAPI.SearchRepositories(query: query)
        
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.delegate?.interactor(self, didRetrieveRepositories: response.items)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.interactor(self, didFailWithError: error)
                }
            }
        }
    }
}
