//
//  DetailPresenter.swift
//  Practice
//
//  Created by Yuka Matsuo on 20/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import Foundation

class DetailViewPresenter {

    private weak var view: DetailView?
    private let router: DetailWireframe
    private let repository: Repository

    init(view: DetailView, router: DetailWireframe, repository: Repository) {
        self.view = view
        self.router = router
        self.repository = repository
    }
}

extension DetailViewPresenter: DetailViewPresentable {

    func viewDidLoad() {
        view?.set(title: repository.fullName)
        
        let url = URL(string: repository.htmlUrl)!
        view?.load(request: URLRequest(url: url))
    }
}
