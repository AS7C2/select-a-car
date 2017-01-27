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
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (true, 15), (true, 15)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                XCTAssertEqual(30, presenter.numberOfManufacturers)
                viewDelegate.refreshCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(0, interactor.lastRequestedPage!.page)
                    XCTAssertEqual(15, presenter.numberOfManufacturers)
                }
                presenter.refresh()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadSuccess_incrementsNextPage() {
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (true, 15), (true, 15)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                XCTAssertEqual(30, presenter.numberOfManufacturers)
                viewDelegate.loadMoreCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(2, interactor.lastRequestedPage!.page)
                    XCTAssertEqual(45, presenter.numberOfManufacturers)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testRefreshFail_doesNotResetNextPage() {
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (true, 15), (false, nil), (true, 15)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                XCTAssertEqual(30, presenter.numberOfManufacturers)
                viewDelegate.errorCompletionHandler = {
                    XCTAssertEqual(0, interactor.lastRequestedPage!.page)
                    XCTAssertEqual(30, presenter.numberOfManufacturers)
                    viewDelegate.loadMoreCompletionHandler = {
                        expectation.fulfill()
                        XCTAssertEqual(2, interactor.lastRequestedPage!.page)
                        XCTAssertEqual(45, presenter.numberOfManufacturers)
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
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (false, nil), (false, nil)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            viewDelegate.errorCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                XCTAssertEqual(15, presenter.numberOfManufacturers)
                viewDelegate.errorCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                    XCTAssertEqual(15, presenter.numberOfManufacturers)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testRefreshSuccess_ContainsData() {
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (false, nil), (false, nil)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = {
            expectation.fulfill()
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            for i in 0..<presenter.numberOfManufacturers {
                XCTAssertEqual(107, presenter.manufacturer(atIndex: i).id)
                XCTAssertEqual("Bentley", presenter.manufacturer(atIndex: i).name)
            }
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadMore_NoData_ShouldNotIncrementNextPage() {
        let interactor = SpyManufacturersInteractor(results: [(true, 15), (true, 0), (true, 0)])
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: interactor,
                selectCarInteractor: SelectCarInteractor())
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.page)
            XCTAssertEqual(15, presenter.numberOfManufacturers)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                XCTAssertEqual(15, presenter.numberOfManufacturers)
                viewDelegate.loadMoreCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(1, interactor.lastRequestedPage!.page)
                    XCTAssertEqual(15, presenter.numberOfManufacturers)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testSelectedManufacturer_PropagatesToSelectCarInteractor() {
        let manufacturersInteractor = SpyManufacturersInteractor(results: [(true, 15)])
        let selectCarInteractor = SelectCarInteractor()
        let selectCarDelegate = SpySelectCarInteractorDelegate()
        selectCarInteractor.selectCarManufacturerDelegate = selectCarDelegate
        selectCarInteractor.selectCarDelegate = selectCarDelegate
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: manufacturersInteractor,
                selectCarInteractor: selectCarInteractor)
        let viewDelegate = SpyManufacturersPresenterViewDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = {
            expectation.fulfill()
            let manufacturer = presenter.manufacturer(atIndex: 0)
            presenter.select(manufacturer: manufacturer)
            XCTAssertEqual(1,  selectCarDelegate.numberOfManufacturerSelectedCalls)
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}
