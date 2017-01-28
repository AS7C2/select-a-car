//
//  EntitiesPresenterTests.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import XCTest
@testable import SelectACar

class EntitiesPresenterTests: XCTestCase {
    func testTitle() {
        let interactor = SpyEntitiesInteractor(results: [])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        XCTAssertEqual("Title", presenter.title)
    }

    func testRefreshSuccess_resetsNextPage() {
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (true, 15), (true, 15)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.number)
            XCTAssertEqual(15, presenter.numberOfEntities)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                XCTAssertEqual(30, presenter.numberOfEntities)
                viewDelegate.refreshCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(0, interactor.lastRequestedPage!.number)
                    XCTAssertEqual(15, presenter.numberOfEntities)
                }
                presenter.refresh()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadSuccess_incrementsNextPage() {
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (true, 15), (true, 15)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.number)
            XCTAssertEqual(15, presenter.numberOfEntities)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                XCTAssertEqual(30, presenter.numberOfEntities)
                viewDelegate.loadMoreCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(2, interactor.lastRequestedPage!.number)
                    XCTAssertEqual(45, presenter.numberOfEntities)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testRefreshFail_doesNotResetNextPage() {
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (true, 15), (false, nil), (true, 15)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.number)
            XCTAssertEqual(15, presenter.numberOfEntities)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                XCTAssertEqual(30, presenter.numberOfEntities)
                viewDelegate.errorCompletionHandler = {
                    XCTAssertEqual(0, interactor.lastRequestedPage!.number)
                    XCTAssertEqual(30, presenter.numberOfEntities)
                    viewDelegate.loadMoreCompletionHandler = {
                        expectation.fulfill()
                        XCTAssertEqual(2, interactor.lastRequestedPage!.number)
                        XCTAssertEqual(45, presenter.numberOfEntities)
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
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (false, nil), (false, nil)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.number)
            XCTAssertEqual(15, presenter.numberOfEntities)
            viewDelegate.errorCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                XCTAssertEqual(15, presenter.numberOfEntities)
                viewDelegate.errorCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                    XCTAssertEqual(15, presenter.numberOfEntities)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testRefreshSuccess_ContainsData() {
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (false, nil), (false, nil)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = {
            expectation.fulfill()
            XCTAssertEqual(15, presenter.numberOfEntities)
            for i in 0..<presenter.numberOfEntities {
                XCTAssertEqual("107", presenter.entity(atIndex: i).id)
                XCTAssertEqual("Bentley", presenter.entity(atIndex: i).name)
            }
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadMore_NoData_ShouldNotIncrementNextPage() {
        let interactor = SpyEntitiesInteractor(results: [(true, 15), (true, 0), (true, 0)])
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: interactor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: SelectCarInteractor()))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = { [unowned viewDelegate] in
            XCTAssertEqual(0, interactor.lastRequestedPage!.number)
            XCTAssertEqual(15, presenter.numberOfEntities)
            viewDelegate.loadMoreCompletionHandler = {
                XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                XCTAssertEqual(15, presenter.numberOfEntities)
                viewDelegate.loadMoreCompletionHandler = {
                    expectation.fulfill()
                    XCTAssertEqual(1, interactor.lastRequestedPage!.number)
                    XCTAssertEqual(15, presenter.numberOfEntities)
                }
                presenter.loadMore()
            }
            presenter.loadMore()
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testSelectedManufacturer_PropagatesToSelectCarInteractor() {
        let entitiesInteractor = SpyEntitiesInteractor(results: [(true, 15)])
        let selectCarInteractor = SelectCarInteractor()
        let selectCarDelegate = SpySelectCarInteractorDelegate()
        selectCarInteractor.selectCarManufacturerDelegate = selectCarDelegate
        selectCarInteractor.selectCarDelegate = selectCarDelegate
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: entitiesInteractor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: selectCarInteractor))
        let viewDelegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = viewDelegate
        let expectation = self.expectation(description: "Expectation")
        viewDelegate.refreshCompletionHandler = {
            expectation.fulfill()
            let manufacturer = presenter.entity(atIndex: 0)
            presenter.select(entity: manufacturer)
            XCTAssertEqual(1,  selectCarDelegate.numberOfManufacturerSelectedCalls)
        }
        presenter.refresh()
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testRefreshInProgress_RejectsLoadMoreRequest() {
        let entitiesInteractor = SpyEntitiesInteractor(results: [(true, 15), (true, 15)], executionTime: 0.5)
        let selectCarInteractor = SelectCarInteractor()
        let presenter = DefaultEntitiesPresenter(
                title: "Title",
                entitiesInteractor: entitiesInteractor,
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: selectCarInteractor))
        let delegate = SpyEntitiesPresenterDelegate()
        presenter.viewDelegate = delegate
        let cancelExpectation = self.expectation(description: "Cancel Expectation")
        let refreshExpectation = self.expectation(description: "Refresh Expectation")
        delegate.cancelCompletionHandler = {
            cancelExpectation.fulfill()
        }
        delegate.refreshCompletionHandler = {
            refreshExpectation.fulfill()
            XCTAssertEqual(15, presenter.numberOfEntities)
        }
        presenter.refresh()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            presenter.loadMore()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(15, presenter.numberOfEntities)
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
