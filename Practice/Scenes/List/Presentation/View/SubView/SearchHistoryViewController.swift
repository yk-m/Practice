//
//  SearchHistoryViewController.swift
//  Practice
//
//  Created by yuka on 2018/12/17.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit

class SearchHistoryViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var items: [RepositorySearchQuery] = [] {
        didSet {
            DispatchQueue.main.async {
                guard let tableView = self.tableView else {
                    return
                }
                tableView.reloadData()
            }
        }
    }
    
    func set(queries: [RepositorySearchQuery]) {
        items = queries
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: UITableViewCell.self, for: indexPath)
        newCell.textLabel?.text = items[indexPath.row].keyword
        return newCell
    }
}
