//
//  SpyManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

@testable import SelectACar

class SpyManufacturersInteractor: ManufacturersInteractor {
    var lastRequestedPage: Page?

    func get(page: Page) {
        lastRequestedPage = page
    }
}


