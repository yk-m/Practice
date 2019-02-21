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
    
    private var items: [Bookmark] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        presenter.refresh()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: ListCell.self, for: indexPath)
        newCell.set(repository: items[indexPath.row].repository, dateFormatter: dateFormatter)
        newCell.delegate = self
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(repository: items[indexPath.row].repository)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BookmarkListViewController: BookmarkListView {
    
    func set(repositories: [Bookmark]) {
        items = repositories
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

extension BookmarkListViewController: ListCellDelegate {
    
    func listCell(_ listCell: ListCell, didTouchUpInsideAt repository: Repository, isBookmarked: Bool) {
        presenter.didTouchBookmarkButton(repository: repository, isBookmarked: isBookmarked)
    }
}
