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
    let path: String
    let manufacturer: Manufacturer

    init(configuration: WebConfiguration, path: String, manufacturer: Manufacturer) {
        self.configuration = configuration
        self.path = path
        self.manufacturer = manufacturer
    }

    func build(page: Page) -> URL {
        return URL(string:"\(configuration.baseURL)\(path)?manufacturer=\(manufacturer.id)&page=\(page.number)&pageSize=\(page.size)&wa_key=\(configuration.clientSecret)")!
    }
}
