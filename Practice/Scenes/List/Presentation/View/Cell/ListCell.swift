//
//  ListCell.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {
    
    @IBOutlet private weak var wrapperView: UIView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var updateAtLabel: UILabel!
    @IBOutlet private weak var authorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            wrapperView.backgroundColor = .lightGray
        } else {
            wrapperView.backgroundColor = .white
        }
    }
    
    func set(repository: Repository, dateFormatter: DateFormatter) {
        nameLabel.text = repository.fullName
        descriptionLabel.text = repository.description ?? "---"
        languageLabel.text = repository.language ?? "---"
        if let date = repository.dateOfUpdate {
            updateAtLabel.text = dateFormatter.string(from: date)
        } else {
            updateAtLabel.text = "---"
        }
        authorImage.kf.indicatorType = .activity
        authorImage.setImage(with: URL(string: repository.owner.avatar_url))
    }
}
