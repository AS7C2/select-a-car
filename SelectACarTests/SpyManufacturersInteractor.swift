//
//  SpyManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation
@testable import SelectACar

enum SpyManufacturersInteractorError: Error {
    case Generic
}

class SpyManufacturersInteractor: ManufacturersInteractor {
    var lastRequestedPage: Page?
    var success: [Bool]
    var successIndex = 0

    init(success: [Bool]) {
        self.success = success
    }

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        DispatchQueue.main.async {
            self.lastRequestedPage = page
            if self.success[self.successIndex] {
                var manufacturers: [Manufacturer] = []
                for _ in 0..<page.size {
                    manufacturers.append(StubManufacturer())
                }
                completionHandler(.Success(manufacturers))
            } else {
                completionHandler(.Failure(SpyManufacturersInteractorError.Generic))
            }
            self.successIndex += 1
        }
    }
}


