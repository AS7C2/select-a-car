//
//  ManufacturersViewController.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ManufacturersViewController: UITableViewController {
    var presenter: EntitiesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = presenter.title
        
        presenter.refresh()

        refreshControl?.addTarget(self, action: #selector(ManufacturersViewController.refresh), for: .valueChanged)
    }

    func refresh() {
        presenter.refresh()
    }
}

extension ManufacturersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfEntities
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath)
                as! EntityCell
        let manufacturer = presenter.entity(atIndex: indexPath.row)
        cell.entity = manufacturer
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cyan
        }
        return cell
    }

    override func tableView(
            _ tableView: UITableView,
            willDisplay cell: UITableViewCell,
            forRowAt indexPath: IndexPath)
    {
        if (indexPath.row == presenter.numberOfEntities - 1) {
            presenter.loadMore()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EntityCell
        presenter.select(entity: cell.entity!)
    }
}

extension ManufacturersViewController: EntitiesPresenterViewDelegate {
    func entitiesPresenterDidRefresh(_ presenter: EntitiesPresenter) {
        endRefreshing()
        tableView.reloadData()
    }

    func entitiesPresenter(_ presenter: EntitiesPresenter, didLoadMoreEntities count: Int) {
            let numberOfManufacturers = presenter.numberOfEntities
            let previousNumberOfManufacturers = numberOfManufacturers - count
            var indexPaths: [IndexPath] = []
            for index in previousNumberOfManufacturers..<numberOfManufacturers {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .bottom)
            self.tableView.endUpdates()
    }

    func entitiesPresenter(_ presenter: EntitiesPresenter, didFailWithError error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true) {
                self.endRefreshing()
            }
        }
    }

    func entitiesPresenterDidCancel(_ presenter: EntitiesPresenter) {
        endRefreshing()
    }

    func endRefreshing() {
        if let refreshControl = self.refreshControl {
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
}
