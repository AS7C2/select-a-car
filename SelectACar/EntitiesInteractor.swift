//
//  EntitiesInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

enum EntitiesInteractorResult {
    case Success([Entity])
    case Failure(Error)
}

protocol EntitiesInteractor {
    func get(page: Page, completionHandler: @escaping (EntitiesInteractorResult) -> Void)
}
