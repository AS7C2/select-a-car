//
//  DefaultManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultManufacturersPresenter: ManufacturersPresenter {
    weak var viewDelegate: ManufacturersPresenterViewDelegate?
    private let interactor: ManufacturersInteractor
    private var nextPage: Page
    private var manufacturers: [Manufacturer] = []

    var numberOfManufacturers: Int {
        get {
            return manufacturers.count
        }
    }

    init(interactor: ManufacturersInteractor) {
        self.interactor = interactor
        nextPage = Page(page: 0, size: 15)
    }

    func refresh() {
        let newNextPage = Page(page: 0, size: 15)
        self.interactor.get(page:newNextPage) { result in
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
        self.interactor.get(page:nextPage) { result in
            switch result {
                case .Success(let manufacturers):
                    self.manufacturers.append(contentsOf: manufacturers)
                    self.nextPage = self.nextPage.next()
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
}
