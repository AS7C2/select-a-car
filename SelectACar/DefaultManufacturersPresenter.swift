//
//  DefaultManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultManufacturersPresenter: ManufacturersPresenter {
    weak var viewDelegate: ManufacturersPresenterViewDelegate?
    weak var coordinatorDelegate: ManufacturersPresenterCoordinatorDelegate?
    private let manufacturersInteractor: ManufacturersInteractor
    private let selectCarInteractor: SelectCarInteractor
    private var nextPage: Page
    private var manufacturers: [Manufacturer] = []

    var numberOfManufacturers: Int {
        get {
            return manufacturers.count
        }
    }

    init(manufacturersInteractor: ManufacturersInteractor, selectCarInteractor: SelectCarInteractor) {
        self.manufacturersInteractor = manufacturersInteractor
        self.selectCarInteractor = selectCarInteractor
        nextPage = Page(page: 0, size: 15)
    }

    func refresh() {
        let newNextPage = Page(page: 0, size: 15)
        self.manufacturersInteractor.get(page:newNextPage) { result in
            switch result {
                case .Success(let manufacturers):
                    self.manufacturers = manufacturers
                    self.nextPage = newNextPage.next()
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.manufacturersPresenterDidRefresh(self)
                    }
                case .Failure(let error):
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.manufacturersPresenter(self, didFailWithError: error)
                    }
            }
        }
    }

    func loadMore() {
        self.manufacturersInteractor.get(page:nextPage) { result in
            switch result {
                case .Success(let manufacturers):
                    if (manufacturers.count > 0) {
                        self.manufacturers.append(contentsOf: manufacturers)
                        self.nextPage = self.nextPage.next()
                    }
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.manufacturersPresenter(self, didLoadMoreManufacturers: manufacturers.count)
                    }
                case .Failure(let error):
                    if let viewDelegate = self.viewDelegate {
                        viewDelegate.manufacturersPresenter(self, didFailWithError: error)
                    }
            }
        }
    }

    func manufacturer(atIndex index: Int) -> Manufacturer {
        return manufacturers[index]
    }

    func select(manufacturer: Manufacturer) {
        selectCarInteractor.select(manufacturer: manufacturer)
    }
}

extension DefaultManufacturersPresenter: SelectCarManufacturerDelegate {
    func selectCarInteractor(_ interactor: SelectCarInteractor, didSelectManufacturer manufacturer: Manufacturer) {
        if let coordinatorDelegate = coordinatorDelegate {
            coordinatorDelegate.manufacturersPresenter(self, didSelectManufacturer: manufacturer)
        }
    }
}
