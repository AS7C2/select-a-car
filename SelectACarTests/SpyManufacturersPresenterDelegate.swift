//
//  SpyManufacturersPresenterDelegate.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

@testable import SelectACar

class SpyManufacturersPresenterDelegate:
        ManufacturersPresenterViewDelegate,
        ManufacturersPresenterCoordinatorDelegate
{
    var refreshCompletionHandler: (() -> Void)?
    var errorCompletionHandler: (() -> Void)?
    var loadMoreCompletionHandler: (() -> Void)?
    var cancelCompletionHandler: (() -> Void)?
    var numberOfManufacturerSelectedCalls: Int = 0

    func manufacturersPresenterDidRefresh(_ presenter: ManufacturersPresenter) {
        if let refreshCompletionHandler = refreshCompletionHandler {
            refreshCompletionHandler()
        }
    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didLoadMoreManufacturers count: Int) {
        if let loadMoreCompletionHandler = loadMoreCompletionHandler {
            loadMoreCompletionHandler()
        }
    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didFailWithError error: Error) {
        if let errorCompletionHandler = errorCompletionHandler {
            errorCompletionHandler()
        }
    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didSelectManufacturer manufacturer: Manufacturer) {
        numberOfManufacturerSelectedCalls += 1
    }

    func manufacturersPresenterDidCancel(_ presenter: ManufacturersPresenter) {
        if let cancelCompletionHandler = cancelCompletionHandler {
            cancelCompletionHandler()
        }
    }
}
