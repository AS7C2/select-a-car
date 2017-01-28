//
//  DefaultEntitiesPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultEntitiesPresenter: EntitiesPresenter {
    let title: String
    weak var viewDelegate: EntitiesPresenterViewDelegate?
    private let entitiesInteractor: EntitiesInteractor
    private let entitySelectionStrategy: EntitySelectionStrategy
    private var nextPage: Page
    private var entities: [Entity] = []
    private var isLoading = false

    var numberOfEntities: Int {
        get {
            return entities.count
        }
    }

    init(title: String,
         entitiesInteractor: EntitiesInteractor,
         entitySelectionStrategy: EntitySelectionStrategy)
    {
        self.title = title
        self.entitiesInteractor = entitiesInteractor
        self.entitySelectionStrategy = entitySelectionStrategy
        nextPage = Page(number: 0, size: 15)
    }

    func refresh() {
        isLoading = true
        let newNextPage = Page(number: 0, size: 15)
        self.entitiesInteractor.get(page:newNextPage) { result in
            self.isLoading = false
            switch result {
                case .Success(let entities):
                    self.entities = entities
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
        self.entitiesInteractor.get(page:nextPage) { result in
            self.isLoading = false
            switch result {
                case .Success(let entities):
                    if (entities.count > 0) {
                        self.entities.append(contentsOf: entities)
                        self.nextPage = self.nextPage.next()
                    }
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenter(self, didLoadMoreEntities: entities.count)
                    }
                case .Failure(let error):
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.entitiesPresenter(self, didFailWithError: error)
                    }
            }
        }
    }

    func entity(atIndex index: Int) -> Entity {
        return entities[index]
    }

    func select(entity: Entity) {
        entitySelectionStrategy.select(entity: entity)
    }
}
