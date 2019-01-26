//
//  SearchHistoryPresenterTests.swift
//  Practice
//
//  Created by Yuka Matsuo on 25/01/2019.
//  Copyright © 2019 yuka. All rights reserved.
//

import XCTest
@testable import Practice

class SearchHistoryPresenterTest: XCTestCase {

    var presenter: SearchHistoryViewPresentable!
    let view = MockViewController()
    let interactor = MockInteractor()
    let router = MockRouter()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        presenter = SearchHistoryViewPresenter(view: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - mock
    class MockViewController: SearchHistoryView {

    }

    class MockInteractor: SearchHistoryUsecase {

    }

    class MockRouter: SearchHistoryWireframe {

    }
}
