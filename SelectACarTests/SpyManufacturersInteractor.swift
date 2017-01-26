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
    var resultsCount: [Int]
    var resultIndex = 0

    init(success: [Bool], resultsCount: [Int]) {
        self.success = success
        self.resultsCount = resultsCount
    }

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        DispatchQueue.main.async {
            self.lastRequestedPage = page
            if self.success[self.resultIndex] {
                var manufacturers: [Manufacturer] = []
                for _ in 0..<self.resultsCount[self.resultIndex] {
                    manufacturers.append(StubManufacturer())
                }
                completionHandler(.Success(manufacturers))
            } else {
                completionHandler(.Failure(SpyManufacturersInteractorError.Generic))
            }
            self.resultIndex += 1
        }
    }
}


