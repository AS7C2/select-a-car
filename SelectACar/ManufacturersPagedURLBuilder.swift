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
    let path: String

    init(configuration: WebConfiguration, path: String) {
        self.configuration = configuration
        self.path = path
    }

    func build(page: Page) -> URL {
        return URL(string:"\(configuration.baseURL)\(path)?page=\(page.number)&pageSize=\(page.size)&wa_key=\(configuration.clientSecret)")!
    }
}
