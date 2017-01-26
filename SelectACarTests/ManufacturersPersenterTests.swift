//
//  ManufacturersPersenterTests.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import XCTest
@testable import SelectACar

class ManufacturersPersenterTests: XCTestCase {
    func testRefreshSuccess_resetsNextPage() {
        let interactor = SpyManufacturersInteractor(success: [true, true, true])
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                viewDelegate.refreshCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(0, interactor.lastRequestedPage!.page)
                }
                presenter.refresh()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testLoadSuccess_incrementsNextPage() {
        let interactor = SpyManufacturersInteractor(success: [true, true, true])
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                viewDelegate.loadMoreCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(2, interactor.lastRequestedPage!.page)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testRefreshFail_doesNotResetNextPage() {
        let interactor = SpyManufacturersInteractor(success: [true, true, false, true])
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                viewDelegate.errorCompletionHandler = {
                    XCTAssertEqual(0, interactor.lastRequestedPage!.page)
                    viewDelegate.loadMoreCompletionHandler = {
                        expectation.fulfill()
                        XCTAssertEqual(2, interactor.lastRequestedPage!.page)
                    }
                    presenter.loadMore()
                }
                presenter.refresh()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadFail_doesNotIncrementNextPage() {
        let interactor = SpyManufacturersInteractor(success: [true, false, false])
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            viewDelegate.errorCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                viewDelegate.errorCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }
}
