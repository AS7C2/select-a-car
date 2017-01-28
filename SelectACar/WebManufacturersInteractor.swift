//
//  WebManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/27/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class WebManufacturersInteractor: ManufacturersInteractor {
    let urlBuilder: PagedURLBuilder
    let entityFactory: EntityFactory

    init(urlBuilder: PagedURLBuilder, entityFactory: EntityFactory) {
        self.urlBuilder = urlBuilder
        self.entityFactory = entityFactory
    }

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        let url = urlBuilder.build(page: page)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.Failure(error))
                }
            } else if let data = data {
                do {
                    var manufacturers: [Entity] = []
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let json = json as? [String: AnyObject] {
                        if let json = json["wkda"] as? [String: String] {
                            for (id, name) in json {
                                manufacturers.append(self.entityFactory.create(id: id, name: name))
                            }
                        }
                    }
                    manufacturers.sort(by: { $0.id < $1.id})
                    DispatchQueue.main.async {
                        completionHandler(.Success(manufacturers))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.Failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.Success([]))
                }
            }
        }.resume()
    }
}

