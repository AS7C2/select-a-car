//
//  DefaultManufacturersPresenter.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

class DefaultManufacturersPresenter: ManufacturersPresenter {
    let numberOfManufacturers = 0
    weak var viewDelegate: ManufacturersPresenterViewDelegate?
    private let interactor: ManufacturersInteractor
    private var nextPage: Page

    init(interactor: ManufacturersInteractor) {
        self.interactor = interactor
        nextPage = Page(page: 0, size: 15)
    }

    func refresh() {
        let newNextPage = Page(page: 0, size: 15)
        self.interactor.get(page:newNextPage) { result in
            switch result {
                case .Success(_):
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
}
