//
//  ListCell.swift
//  Practice
//
//  Created by yuka on 2018/12/16.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

protocol ListCellDelegate: class {
    
    func listCell(_ listCell: ListCell, didTouchUpInsideAt repository: Repository, isBookmarked: Bool)
}

class ListCell: UITableViewCell {
    
    weak var delegate: ListCellDelegate?
    
    @IBOutlet private weak var wrapperView: UIView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var updateAtLabel: UILabel!
    @IBOutlet private weak var authorImage: UIImageView!
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBAction func buttonTouchUpInside(_ sender: Any) {
        guard let repository = repository else {
            return
        }
        
        delegate?.listCell(self, didTouchUpInsideAt: repository, isBookmarked: isBookmarked)
    }
    
    private var indexPath: IndexPath?
    private var repository: Repository?
    private var objects: Results<Bookmark> = (try! Realm()).objects(Bookmark.self)
    private var notificationToken: NotificationToken? {
        didSet {
            oldValue?.invalidate()
        }
    }
    
    var isBookmarked: Bool {
        guard let repository = repository,
            objects.filter({ $0.repository.id == repository.id }).first != nil else {
                return false
        }
        return true
    }
    
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
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func set(repository: Repository, dateFormatter: DateFormatter) {
        self.repository = repository
        
        nameLabel.text = repository.fullName
        descriptionLabel.text = repository.repoDescription ?? "---"
        languageLabel.text = repository.language ?? "---"
        if let date = repository.dateOfUpdate {
            updateAtLabel.text = dateFormatter.string(from: date)
        } else {
            updateAtLabel.text = "---"
        }
        authorImage.kf.indicatorType = .activity
        authorImage.setImage(with: URL(string: repository.owner.avatar_url))
        
        bookmarkButton.isSelected = isBookmarked
        
        notificationToken = objects.observe { [weak self] changes in
            switch changes {
            case .update:
                self?.updateBookmarkButton()
            default:
                break
            }
        }
    }
    
    func updateBookmarkButton() {
        if isBookmarked == true {
            bookmarkButton.isSelected = true
        } else {
            bookmarkButton.isSelected = false
        }
    }
}
