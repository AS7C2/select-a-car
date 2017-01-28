//
//  ManufacturersPagedURLBuilder.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class ManufacturersPagedURLBuilder: PagedURLBuilder {
    let configuration: WebConfiguration

    init(configuration: WebConfiguration) {
        self.configuration = configuration
    }

    func build(page: Page) -> URL {
        return URL(string:"\(configuration.baseURL)/v1/car-types/manufacturer?page=\(page.number)&pageSize=\(page.size)&wa_key=\(configuration.clientSecret)")!
    }
}
