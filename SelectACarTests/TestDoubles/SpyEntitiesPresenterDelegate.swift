//
//  SpyEntitiesPresenterDelegate.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

@testable import SelectACar

class SpyEntitiesPresenterDelegate: EntitiesPresenterViewDelegate {
    var refreshCompletionHandler: (() -> Void)?
    var errorCompletionHandler: (() -> Void)?
    var loadMoreCompletionHandler: (() -> Void)?
    var cancelCompletionHandler: (() -> Void)?

    func entitiesPresenterDidRefresh(_ presenter: EntitiesPresenter) {
        if let refreshCompletionHandler = refreshCompletionHandler {
            refreshCompletionHandler()
        }
    }

    func entitiesPresenter(_ presenter: EntitiesPresenter, didLoadMoreEntities count: Int) {
        if let loadMoreCompletionHandler = loadMoreCompletionHandler {
            loadMoreCompletionHandler()
        }
    }

    func entitiesPresenter(_ presenter: EntitiesPresenter, didFailWithError error: Error) {
        if let errorCompletionHandler = errorCompletionHandler {
            errorCompletionHandler()
        }
    }

    func entitiesPresenterDidCancel(_ presenter: EntitiesPresenter) {
        if let cancelCompletionHandler = cancelCompletionHandler {
            cancelCompletionHandler()
        }
    }
}
