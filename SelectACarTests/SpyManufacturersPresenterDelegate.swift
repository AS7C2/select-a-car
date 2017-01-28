//
//  SpyManufacturersPresenterDelegate.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

@testable import SelectACar

class SpyManufacturersPresenterDelegate: ManufacturersPresenterViewDelegate {
    var refreshCompletionHandler: (() -> Void)?
    var errorCompletionHandler: (() -> Void)?
    var loadMoreCompletionHandler: (() -> Void)?
    var cancelCompletionHandler: (() -> Void)?

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

    func manufacturersPresenterDidCancel(_ presenter: ManufacturersPresenter) {
        if let cancelCompletionHandler = cancelCompletionHandler {
            cancelCompletionHandler()
        }
    }
}
