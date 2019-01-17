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
    
    private lazy var searchHistoryView: SearchHistoryViewController = {
        let view = SearchHistoryViewController()
        view.delegate = self
        return view
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchHistoryView)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(repository: items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchHistoryViewDelegate
extension ListViewController: SearchHistoryViewDelegate {
    
    func view(_ view: SearchHistoryViewController, didSelectRowAt query: RepositorySearchQuery) {
        searchController.searchBar.text = query.keyword
    }
}

// MARK: - UISearchControllerDelegate
extension ListViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        presenter.willPresentSearchController()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        presenter.rollbackSearchText()
    }
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filter(text: searchController.searchBar.text ?? "")
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        defer {
            searchController.dismiss(animated: true)
        }
        
        presenter.set(searchText: searchBar.text ?? "")
    }
}

// MARK: - ListView
extension ListViewController: ListView {
    
    func set(searchText: String) {
        searchController.searchBar.text = searchText
    }
    
    func set(queries: [RepositorySearchQuery]) {
        searchHistoryView.set(queries: queries)
    }
    
    func set(repositories: [Repository]) {
        items = repositories
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController.singleBtnAlert(with: title, message: message, completion: nil)
        present(alert, animated: true, completion: nil)
    }
}
