//
//  SelectCarInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/25/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

protocol SelectCarManufacturerDelegate: class {
    func selectCarInteractor(
            _ interactor: SelectCarInteractor,
            didSelectManufacturer manufacturer: Manufacturer)
}

protocol SelectCarDelegate: class {
    func selectCarInteractor(
            _ interactor: SelectCarInteractor,
            didSelectManufacturer manufacturer: Manufacturer,
            model: Model)
}

class SelectCarInteractor {
    weak var selectCarManufacturerDelegate: SelectCarManufacturerDelegate?
    weak var selectCarDelegate: SelectCarDelegate?

    private var manufacturer: Manufacturer?
    private var model: Model?

    func selectedManufacturer() -> Manufacturer? {
        return manufacturer
    }

    func select(manufacturer: Manufacturer) {
        self.manufacturer = manufacturer

        if let manufacturer = self.manufacturer, let delegate = self.selectCarManufacturerDelegate {
            delegate.selectCarInteractor(self, didSelectManufacturer: manufacturer)
        }
    }

    func select(model: Model) {
        self.model = model

        if let manufacturer = self.manufacturer, let model = self.model, let delegate = self.selectCarDelegate {
            delegate.selectCarInteractor(self, didSelectManufacturer: manufacturer, model: model)
        }
    }
}

