//
//  ManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

protocol ManufacturersPresenter {
    var numberOfManufacturers: Int { get }

    func refresh()

    func loadMore()
}
