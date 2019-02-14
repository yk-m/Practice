//
//  BookmarkListViewController.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkListViewController: UITableViewController {

    var presenter: BookmarkListViewPresentable!
    
    private var items: [Bookmark] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/M/d H:s"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bookmarks"
        
        presenter.viewDidLoad()
        
        tableView.register(cellType: ListCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .almostWhite
        
        edgesForExtendedLayout = .all
        tableView.contentInsetAdjustmentBehavior = .always
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        presenter.refresh()
    }
}

extension BookmarkListViewController: BookmarkListView {
    
    func reload() {
        tableView.reloadData()
    }
    
    func update(deletions: [Int], insertions: [Int], modifications: [Int]) {
        tableView.beginUpdates()
        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                             with: .automatic)
        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.endUpdates()
    }
    
    func set(repositories: [Bookmark]) {
        items = repositories
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookmarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: ListCell.self, for: indexPath)
        newCell.set(repository: items[indexPath.row].repository, dateFormatter: dateFormatter)
        newCell.delegate = self
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(repository: items[indexPath.row].repository)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BookmarkListViewController: ListCellDelegate {
    
    func listCell(_ listCell: ListCell, didTouchUpInsideAt repository: Repository, isBookmarked: Bool) {
        presenter.didTouchBookmarkButton(repository: repository, isBookmarked: isBookmarked)
    }
}
