//
//  WebConfiguration.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

protocol WebConfiguration {
    var baseURL: String { get }
    var clientSecret: String { get }
}
