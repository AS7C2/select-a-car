//
//  WebManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/27/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class WebManufacturersInteractor: ManufacturersInteractor {
    let configuration: WebConfiguration

    init(configuration: WebConfiguration) {
        self.configuration = configuration
    }

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        let url = URL(
                string:"?page=\(page.number)&pageSize=\(page.size)&wa_key=\(configuration.clientSecret)",
                relativeTo:configuration.baseURL.appendingPathComponent("v1/car-types/manufacturer"))!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.Failure(error))
                }
            } else if let data = data {
                do {
                    var manufacturers: [Manufacturer] = []
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let json = json as? [String: AnyObject] {
                        if let json = json["wkda"] as? [String: String] {
                            for (id, name) in json {
                                manufacturers.append(DefaultManufacturer(id: id, name: name))
                            }
                        }
                    }
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

