//
//  EntitiesPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

protocol EntitiesPresenterViewDelegate: class {
    func entitiesPresenterDidRefresh(_ presenter: EntitiesPresenter)

    func entitiesPresenter(_ presenter: EntitiesPresenter, didLoadMoreEntities count: Int)

    func entitiesPresenterDidCancel(_ presenter: EntitiesPresenter)

    func entitiesPresenter(_ presenter: EntitiesPresenter, didFailWithError error: Error)
}

protocol EntitiesPresenter {
    var title: String { get }

    weak var viewDelegate: EntitiesPresenterViewDelegate? { get set }

    var numberOfEntities: Int { get }

    func entity(atIndex index: Int) -> Entity

    func refresh()

    func loadMore()

    func select(entity: Entity)
}
