//
//  BookmarkListViewController.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import UIKit

class BookmarkListViewController: UIViewController {

    var presenter: BookmarkListViewPresentable!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: ListCell.self)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
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
        dateFormatter.dateFormat = "yyyy/MM/dd hh:ss:mm"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bookmarks"
        
        presenter.viewDidLoad()
    }
}

extension BookmarkListViewController: BookmarkListView {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookmarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
