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

}

// MARK: - presenter
protocol ListViewPresentable: class {

    func viewDidLoad()
}

// MARK: - router
protocol ListWireframe: class {

}
