//
//  ManufacturersTableViewController.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ManufacturersTableViewController: UITableViewController {
}

extension ManufacturersTableViewController: ManufacturersPresenterViewDelegate {
    func manufacturersPresenterDidRefresh(_ presenter: ManufacturersPresenter) {

    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didLoadMoreManufacturers count: Int) {

    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didFailWithError error: Error) {

    }
}
