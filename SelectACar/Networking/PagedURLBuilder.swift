//
//  PagedURLBuilder.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

protocol PagedURLBuilder {
    func build(page: Page) -> URL
}
