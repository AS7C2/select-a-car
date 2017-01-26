//
//  ManufacturersViewController.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ManufacturersViewController: UITableViewController {
    var presenter: ManufacturersPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.refresh()
    }
}

extension ManufacturersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfManufacturers
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Manufacturer", for: indexPath)
                as! ManufacturerCell
        let manufacturer = presenter.manufacturer(atIndex: indexPath.row)
        cell.manufactuer = manufacturer
        return cell
    }
}

extension ManufacturersViewController: ManufacturersPresenterViewDelegate {
    func manufacturersPresenterDidRefresh(_ presenter: ManufacturersPresenter) {
        tableView.reloadData()
    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didLoadMoreManufacturers count: Int) {

    }

    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didFailWithError error: Error) {

    }
}
