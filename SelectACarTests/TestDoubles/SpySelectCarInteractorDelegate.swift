//
//  SpySelectCarInteractorDelegate.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/25/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

@testable import SelectACar

class SpySelectCarInteractorDelegate: SelectCarManufacturerDelegate, SelectCarDelegate {
    private(set) var numberOfCarSelectedCalls: Int = 0
    private(set) var numberOfManufacturerSelectedCalls: Int = 0
    private(set) var lastSelectedManufacturer: Manufacturer?
    private(set) var lastSelectedModel: Model?

    func selectCarInteractor(_ interactor: SelectCarInteractor, didSelectManufacturer manufacturer: Manufacturer) {
        numberOfManufacturerSelectedCalls += 1
        lastSelectedManufacturer = manufacturer
    }

    func selectCarInteractor(
            _ interactor: SelectCarInteractor,
            didSelectManufacturer manufacturer: Manufacturer,
            model: Model)
    {
        numberOfCarSelectedCalls += 1
        lastSelectedManufacturer = manufacturer
        lastSelectedModel = model
    }
}
