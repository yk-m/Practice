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
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var authorImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
    
    func set(repository: Repository) {
        nameLabel.text = repository.fullName
        authorLabel.text = String(repository.owner.id)
        authorImage.kf.indicatorType = .activity
        authorImage.setImage(with: URL(string: repository.owner.avatar_url))
        descriptionLabel.text = repository.description
    }
}
