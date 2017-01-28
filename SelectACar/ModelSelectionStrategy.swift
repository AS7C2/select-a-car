//
//  ModelSelectionStrategy.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class ModelSelectionStrategy: EntitySelectionStrategy {
    private let interactor: SelectCarInteractor

    init (interactor: SelectCarInteractor) {
        self.interactor = interactor
    }

    func select(entity: Entity) {
        interactor.select(model: entity as! Model)
    }
}
