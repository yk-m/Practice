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
    func refresh()
    func reload()
    func update(deletions: [Int], insertions: [Int], modifications: [Int])
}

// MARK: - presenter
protocol BookmarkListViewPresentable: class {

    func viewDidLoad()
    func didSelectRow(repository: Repository)
    func didTouchBookmarkButton(repository: Repository, isBookmarked: Bool)
}

// MARK: - router
protocol BookmarkListWireframe: class {

    func showDetail(repository: Repository)
}
