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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: ListCell.self)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private var items: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        presenter.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: ListCell.self, for: indexPath)
        newCell.set(repository: items[indexPath.row])
        return newCell
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        defer {
            searchController.dismiss(animated: true)
        }
        guard let searchText = searchBar.text,
            searchText != "" else {
                return
        }
        
        presenter.set(searchText: searchText)
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
