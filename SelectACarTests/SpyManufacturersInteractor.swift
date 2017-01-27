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
    var results: [(success: Bool, count: Int?)]
    var resultIndex = 0
    var executionTime: Double

    init(results: [(Bool, Int?)], executionTime: Double) {
        self.results = results
        self.executionTime = executionTime
    }

    convenience init(results: [(Bool, Int?)]) {
        self.init(results: results, executionTime: 0)
    }

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + executionTime) {
            self.lastRequestedPage = page
            if self.results[self.resultIndex].success {
                var manufacturers: [Manufacturer] = []
                for _ in 0..<self.results[self.resultIndex].count! {
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


