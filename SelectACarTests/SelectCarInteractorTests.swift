//
//  SelectCarInteractorTests.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/25/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import XCTest
@testable import SelectACar

class SelectCarInteractorTests: XCTestCase {
    func testSelectManufacturerOnly_notifiesManufacturedSelected_andDoesNotNotifyCarSelected() {
        let interactor = SelectCarInteractor()
        let manufacturer = StubManufacturer()
        let delegate = SpySelectCarInteractorDelegate()
        interactor.selectCarDelegate = delegate
        interactor.selectCarManufacturerDelegate = delegate
        interactor.select(manufacturer: manufacturer)
        XCTAssertEqual(1, delegate.numberOfManufacturerSelectedCalls)
        XCTAssertEqual(0, delegate.numberOfCarSelectedCalls)
    }

    func testSelectModelOnly_doesNotNotifyCarSelected() {
        let interactor = SelectCarInteractor()
        let model = StubModel()
        let delegate = SpySelectCarInteractorDelegate()
        interactor.selectCarDelegate = delegate
        interactor.selectCarManufacturerDelegate = delegate
        interactor.select(model: model);
        XCTAssertEqual(0, delegate.numberOfManufacturerSelectedCalls)
        XCTAssertEqual(0, delegate.numberOfCarSelectedCalls)
    }

    func testSelectManufacturer_andThenModel_NotifiesCarSelected() {
        let interactor = SelectCarInteractor()
        let delegate = SpySelectCarInteractorDelegate()
        interactor.selectCarDelegate = delegate
        interactor.selectCarManufacturerDelegate = delegate
        let manufacturer = StubManufacturer()
        let model = StubModel()
        interactor.select(manufacturer: manufacturer)
        interactor.select(model: model)
        XCTAssertEqual(1, delegate.numberOfManufacturerSelectedCalls)
        XCTAssertEqual(1, delegate.numberOfCarSelectedCalls)
        XCTAssertEqual(manufacturer.id, delegate.lastSelectedManufacturer!.id)
        XCTAssertEqual(manufacturer.name, delegate.lastSelectedManufacturer!.name)
        XCTAssertEqual(model.name, delegate.lastSelectedModel!.name)
    }
}
