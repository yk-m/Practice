//
//  BookmarkListPresenter.swift
//  Practice
//
//  Created by Yuka Matsuo on 24/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import Foundation
import RealmSwift

class BookmarkListViewPresenter {

    private weak var view: BookmarkListView?
    private let router: BookmarkListWireframe
    private let interactor: BookmarkUsecase
    
    var notificationToken: NotificationToken?

    init(view: BookmarkListView, router: BookmarkListWireframe, interactor: BookmarkUsecase) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}

extension BookmarkListViewPresenter: BookmarkListViewPresentable {

    func viewDidLoad() {
        view?.set(repositories: Array(interactor.all()))
        notificationToken = interactor.observe { [weak self] change in
            guard let repositories = self?.interactor.all() else {
                return
            }
            self?.view?.set(repositories: Array(repositories))
            
            switch change {
            case .initial:
                self?.view?.reload()
            case .update(_, let deletions, let insertions, let modifications):
                self?.view?.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error:
                break
            }
        }
    }
    
    func didSelectRow(repository: Repository) {
        router.showDetail(repository: repository)
    }
    
    func didTouchBookmarkButton(repository: Repository, isBookmarked: Bool) {
        if isBookmarked {
            interactor.remove(repository: repository)
        } else {
            interactor.add(repository: repository)
        }
    }
}
