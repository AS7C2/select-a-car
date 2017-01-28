//
//  ManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

enum ManufacturersInteractorResult {
    case Success([Entity])
    case Failure(Error)
}

protocol ManufacturersInteractor {
    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void)
}
