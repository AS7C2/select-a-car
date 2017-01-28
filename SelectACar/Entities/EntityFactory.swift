//
//  EntityFactory.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

protocol EntityFactory {
    func create(id: String, name: String) -> Entity
}
