//
//  ModelsPagedURLBuilder.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class ModelsPagedURLBuilder: PagedURLBuilder {
    let configuration: WebConfiguration
    let manufacturer: Manufacturer

    init(configuration: WebConfiguration, manufacturer: Manufacturer) {
        self.configuration = configuration
        self.manufacturer = manufacturer
    }

    func build(page: Page) -> URL {
        return URL(string:"\(configuration.baseURL)/v1/car-types/main-types?manufacturer=\(manufacturer.id)&page=\(page.number)&pageSize=\(page.size)&wa_key=\(configuration.clientSecret)")!
    }
}
