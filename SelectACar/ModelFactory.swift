//
//  ModelFactory.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class ModelFactory: EntityFactory {
    func create(id: String, name: String) -> Entity {
        return DefaultModel(id: id, name: name)
    }
}
