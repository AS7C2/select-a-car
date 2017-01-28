//
//  SpyEntitiesInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation
@testable import SelectACar

enum SpyEntitiesInteractorError: Error {
    case Generic
}

class SpyEntitiesInteractor: EntitiesInteractor {
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

    func get(page: Page, completionHandler: @escaping (EntitiesInteractorResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + executionTime) {
            self.lastRequestedPage = page
            if self.results[self.resultIndex].success {
                var entities: [Entity] = []
                for _ in 0..<self.results[self.resultIndex].count! {
                    entities.append(StubManufacturer())
                }
                completionHandler(.Success(entities))
            } else {
                completionHandler(.Failure(SpyEntitiesInteractorError.Generic))
            }
            self.resultIndex += 1
        }
    }
}


