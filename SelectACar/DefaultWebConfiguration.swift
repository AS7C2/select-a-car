//
//  DefaultWebConfiguration.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class DefaultWebConfiguration: WebConfiguration {
    let baseURL: URL = URL(string: "<BASE URL>")!
    let clientSecret: String = "<CLIENT SECRET>"
}