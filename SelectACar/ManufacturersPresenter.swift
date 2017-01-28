//
//  ManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

protocol ManufacturersPresenterViewDelegate: class {
    func manufacturersPresenterDidRefresh(_ presenter: ManufacturersPresenter)

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didLoadMoreManufacturers count: Int)

    func manufacturersPresenterDidCancel(_ presenter: ManufacturersPresenter)

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didFailWithError error: Error)
}

protocol ManufacturersPresenter {
    weak var viewDelegate: ManufacturersPresenterViewDelegate? { get set }

    var numberOfManufacturers: Int { get }

    func manufacturer(atIndex index: Int) -> Entity

    func refresh()

    func loadMore()

    func select(manufacturer: Entity)
}
