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
    func testNew_hasNoData() {
        let interactor = SpyManufacturersInteractor()
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        XCTAssertEqual(0, presenter.numberOfManufacturers)
    }

    func testNew_onRefresh_requestsFirstDataPage() {
        let interactor = SpyManufacturersInteractor()
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        presenter.refresh()
        XCTAssertEqual(0, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
    }

    func test_onLoadMore_requestsNextDataPage() {
        let interactor = SpyManufacturersInteractor()
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        presenter.refresh()
        presenter.loadMore()
        XCTAssertEqual(1, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
    }

    func test_refreshLoadLoadRefresh_requestsCorrectDataPages() {
        let interactor = SpyManufacturersInteractor()
        let presenter = DefaultManufacturersPresenter(interactor: interactor)
        presenter.refresh()
        XCTAssertEqual(0, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
        presenter.loadMore()
        XCTAssertEqual(1, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
        presenter.loadMore()
        XCTAssertEqual(2, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
        presenter.refresh()
        XCTAssertEqual(0, interactor.lastRequestedPage!.page)
        XCTAssertEqual(15, interactor.lastRequestedPage!.size)
    }
}
