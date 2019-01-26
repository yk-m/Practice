//
//  ListViewController.swift
//  Practice
//
//  Created by Yuka Matsuo on 16/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var presenter: ListViewPresentable!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: ListCell.self)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private lazy var searchHistoryView = SearchHistoryRouter.assembleModules(delegate: self)
    private lazy var searchController: UISearchController = searchHistoryView.searchController
    
    private var items: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/M/d HH:ss"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchHistoryView.listViewDidLoad()
    }
}

// MARK: - ListView
extension ListViewController: ListView {
    
    func set(repositories: [Repository]) {
        items = repositories
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController.singleBtnAlert(with: title, message: message, completion: nil)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: ListCell.self, for: indexPath)
        newCell.set(repository: items[indexPath.row], dateFormatter: dateFormatter)
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(repository: items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchHistoryViewDelegate
extension ListViewController: SearchHisotryDelegate {
    
    func searchHistory(_ searchHistory: SearchHistoryRouter, didSelect searchText: String?) {
        searchController.dismiss(animated: true)
        presenter.set(searchText: searchText)
    }
}
