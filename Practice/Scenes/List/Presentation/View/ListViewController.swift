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
    
    var items = ["test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(with: ListCell.self, for: indexPath)
        newCell.set(text: items[indexPath.row])
        return newCell
    }
}

extension ListViewController: ListView {

}
