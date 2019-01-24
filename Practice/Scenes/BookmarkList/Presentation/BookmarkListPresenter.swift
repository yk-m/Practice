//
//  BookmarkListPresenter.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import Foundation

class BookmarkListViewPresenter {

    private weak var view: BookmarkListView?
    private let router: BookmarkListWireframe

    init(view: BookmarkListView, router: BookmarkListWireframe) {
        self.view = view
        self.router = router
    }
}

extension BookmarkListViewPresenter: BookmarkListViewPresentable {

    func viewDidLoad() {

    }
    
    func didSelectRow(repository: Repository) {
        router.showDetail(repository: repository)
    }
}
