//
//  ListContract.swift
//  Practice
//
//  Created by Yuka Matsuo on 16/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import Foundation

// MARK: - view
protocol ListView: class {

    func set(searchText: String)
    func set(queries: [RepositorySearchQuery])
    func set(repositories: [Repository])
    func presentAlert(title: String, message: String)
}

// MARK: - presenter
protocol ListViewPresentable: class {

    func viewDidLoad()
    func willPresentSearchController()
    func filter(text: String)
    func set(searchText: String)
}

// MARK: - router
protocol ListWireframe: class {

}
