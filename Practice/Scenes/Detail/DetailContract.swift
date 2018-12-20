//
//  DetailContract.swift
//  Practice
//
//  Created by Yuka Matsuo on 20/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import Foundation

// MARK: - view
protocol DetailView: class {

    func set(title: String)
    func load(request urlRequest: URLRequest)
}

// MARK: - presenter
protocol DetailViewPresentable: class {

    func viewDidLoad()
}

// MARK: - router
protocol DetailWireframe: class {

}
