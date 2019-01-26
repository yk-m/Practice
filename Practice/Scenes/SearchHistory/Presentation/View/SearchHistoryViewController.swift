//
//  SearchHistoryViewController.swift
//  Practice
//
//  Created by yuka on 2018/12/17.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit

class SearchHistoryViewController: UIViewController {
    
    var presenter: SearchHistoryViewPresentable!
        
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: HistoryCell.className, bundle: nil), forCellReuseIdentifier: HistoryCell.className)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: self)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        return searchController
    }()
    
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
}

extension SearchHistoryViewController: SearchHistoryView {
    
    func listViewDidLoad() {
        presenter.listViewDidLoad()
    }
    
    func set(searchText: String) {
        searchController.searchBar.text = searchText
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
        let newCell = tableView.dequeueReusableCell(with: HistoryCell.self, for: indexPath)
        newCell.set(keyword: items[indexPath.row].keyword)
        newCell.delegate = self
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(query: items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchControllerDelegate
extension SearchHistoryViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        presenter.willPresentSearchController()
    }
}

// MARK: - UISearchResultsUpdating
extension SearchHistoryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults(searchText: searchController.searchBar.text)
    }
}

// MARK: - UISearchBarDelegate
extension SearchHistoryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarSearchButtonClicked(searchText: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonClicked()
    }
}

// MARK: - HistoryCellDelegate
extension SearchHistoryViewController: HistoryCellDelegate {
    
    func historyCell(_ historyCell: HistoryCell, didTouchUpInside keyword: String) {
        searchController.searchBar.text = keyword
    }
}
