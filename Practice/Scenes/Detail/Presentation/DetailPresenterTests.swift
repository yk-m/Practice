//
//  DetailPresenterTests.swift
//  Practice
//
//  Created by Yuka Matsuo on 20/12/2018.
//  Copyright © 2018 yuka. All rights reserved.
//

import XCTest

class DetailPresenterTest: XCTestCase {

    var presenter: DetailViewPresentable!
    let view = MockViewController()
    let interactor = MockInteractor()
    let router = MockRouter()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        presenter = DetailViewPresenter(view: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - mock
    class MockViewController: DetailView {

    }

    class MockInteractor: DetailUsecase {

    }

    class MockRouter: DetailWireframe {

    }
}
