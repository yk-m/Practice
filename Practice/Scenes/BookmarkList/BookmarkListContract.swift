//
//  BookmarkListContract.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import Foundation

// MARK: - view
protocol BookmarkListView: class {

}

// MARK: - presenter
protocol BookmarkListViewPresentable: class {

    func viewDidLoad()
    func didSelectRow(repository: Repository)
}

// MARK: - router
protocol BookmarkListWireframe: class {

    func showDetail(repository: Repository)
}
