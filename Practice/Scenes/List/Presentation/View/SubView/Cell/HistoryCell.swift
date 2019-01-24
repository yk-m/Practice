//
//  HistoryCell.swift
//  Practice
//
//  Created by sci01725 on 2019/01/17.
//  Copyright © 2019 Yuka Matsuo. All rights reserved.
//

import UIKit

protocol HistoryCellDelegate: class {
    
    func historyCell(_ historyCell: HistoryCell, didTouchUpInside keyword: String)
}

class HistoryCell: UITableViewCell {
    
    weak var delegate: HistoryCellDelegate?
    
    @IBOutlet private weak var label: UILabel! {
        didSet {
        label.text = keyword
        }
    }
    @IBOutlet private weak var button: UIButton!
    @IBAction private func didTouchUpInside(_ sender: Any) {
        guard let keyword = keyword else {
            return
        }
        delegate?.historyCell(self, didTouchUpInside: keyword)
    }
    
    var keyword: String?

    func set(keyword: String) {
        self.keyword = keyword
        
        guard let label = label else {
            return
        }
        label.text = keyword
    }
}
