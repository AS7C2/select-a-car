//
//  SelectCarInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/25/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class SelectCarInteractor {
    weak var delegate: SelectCarInteractorDelegate?

    private var manufacturer: Manufacturer?
    private var model: Model?

    func select(manufacturer: Manufacturer) {
        self.manufacturer = manufacturer
    }

    func select(model: Model) {
        self.model = model

        if let manufacturer = self.manufacturer, let model = self.model, let delegate = self.delegate {
            delegate.selectCarInteractor(self, didSelectManufacturer: manufacturer, model: model)
        }
    }
}

protocol SelectCarInteractorDelegate: class {
    func selectCarInteractor(
            _ interactor: SelectCarInteractor,
            didSelectManufacturer manufacturer: Manufacturer,
            model: Model)
}


