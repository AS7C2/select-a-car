//
//  DefaultManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultManufacturersPresenter: ManufacturersPresenter {
    let numberOfManufacturers = 0
    private let interactor: ManufacturersInteractor
    private var nextPage: Page

    init(interactor: ManufacturersInteractor) {
        self.interactor = interactor
        nextPage = Page(page: 0, size: 15)
    }

    func refresh() {
        nextPage = Page(page: 0, size: 15)
        self.interactor.get(page:nextPage)
        nextPage = nextPage.next()
    }

    func loadMore() {
        self.interactor.get(page:nextPage)
        nextPage = nextPage.next()
    }
}
