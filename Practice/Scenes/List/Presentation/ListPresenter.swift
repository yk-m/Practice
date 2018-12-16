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

    init(view: ListView, router: ListWireframe) {
        self.view = view
        self.router = router
    }
}

extension ListViewPresenter: ListViewPresentable {

    func viewDidLoad() {

    }
}
