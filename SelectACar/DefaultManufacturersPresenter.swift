//
//  DefaultManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultManufacturersPresenter: EntitiesPresenter {
    let title: String
    weak var viewDelegate: EntitiesPresenterViewDelegate?
    private let manufacturersInteractor: ManufacturersInteractor
    private let entitySelectionStrategy: EntitySelectionStrategy
    private var nextPage: Page
    private var manufacturers: [Entity] = []
    private var isLoading = false

    var numberOfEntities: Int {
        get {
            return manufacturers.count
        }
    }

    init(title: String,
            manufacturersInteractor: ManufacturersInteractor,
            entitySelectionStrategy: EntitySelectionStrategy)
    {
        self.title = title
        self.manufacturersInteractor = manufacturersInteractor
        self.entitySelectionStrategy = entitySelectionStrategy
        nextPage = Page(number: 0, size: 15)
    }

    func refresh() {
        isLoading = true
        let newNextPage = Page(number: 0, size: 15)
        self.manufacturersInteractor.get(page:newNextPage) { result in
            self.isLoading = false
            switch result {
                case .Success(let manufacturers):
                    self.manufacturers = manufacturers
                    self.nextPage = newNextPage.next()
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenterDidRefresh(self)
                    }
                case .Failure(let error):
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenter(self, didFailWithError: error)
                    }
            }
        }
    }

    func loadMore() {
        if isLoading {
            if let viewDelegate = self.viewDelegate {
                viewDelegate.entitiesPresenterDidCancel(self)
            }
            return
        }

        isLoading = true
        self.manufacturersInteractor.get(page:nextPage) { result in
            self.isLoading = false
            switch result {
                case .Success(let manufacturers):
                    if (manufacturers.count > 0) {
                        self.manufacturers.append(contentsOf: manufacturers)
                        self.nextPage = self.nextPage.next()
                    }
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenter(self, didLoadMoreEntities: manufacturers.count)
                    }
                case .Failure(let error):
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenter(self, didFailWithError: error)
                    }
            }
        }
    }

    func entity(atIndex index: Int) -> Entity {
        return manufacturers[index]
    }

    func select(entity: Entity) {
        entitySelectionStrategy.select(entity: entity)
    }
}
