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
    
    private var notificationToken: NotificationToken?
    private var shouldUpdate: Bool = false

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
            switch change {
            case .update:
                self?.shouldUpdate = true
            default:
                break
            }
        }
    }
    
    func viewWillAppear() {
        guard shouldUpdate else {
            return
        }
        view?.set(repositories: Array(interactor.all()))
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
    
    func refresh() {
        view?.set(repositories: Array(interactor.all()))
    }
}
