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

    func set(repositories: [Bookmark])
}

// MARK: - presenter
protocol BookmarkListViewPresentable: class {

    func viewDidLoad()
    func viewWillAppear()
    func didSelectRow(repository: Repository)
    func didTouchBookmarkButton(repository: Repository, isBookmarked: Bool)
    func refresh()
}

// MARK: - router
protocol BookmarkListWireframe: class {

    func showDetail(repository: Repository)
}
