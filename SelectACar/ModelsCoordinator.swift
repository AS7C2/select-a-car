//
//  ModelsCoordinator.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/28/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ModelsCoordinator {
    let navigationController: UINavigationController
    let selectCarInteractor: SelectCarInteractor

    init(navigationController: UINavigationController, selectCarInteractor: SelectCarInteractor) {
        self.navigationController = navigationController
        self.selectCarInteractor = selectCarInteractor
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Manufacturers")
                as! ManufacturersViewController
        let urlBuilder = ModelsPagedURLBuilder(
                configuration: DefaultWebConfiguration(),
                manufacturer: self.selectCarInteractor.selectedManufacturer()!)
        let presenter = DefaultEntitiesPresenter(
                title: "Models",
                entitiesInteractor: WebManufacturersInteractor(
                        urlBuilder: urlBuilder,
                        entityFactory: ModelFactory()),
                entitySelectionStrategy: ModelSelectionStrategy(interactor: selectCarInteractor))
        selectCarInteractor.selectCarDelegate = self
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension ModelsCoordinator: SelectCarDelegate {
    func selectCarInteractor(
            _ interactor: SelectCarInteractor,
            didSelectManufacturer manufacturer: Manufacturer,
            model: Model)
    {
        let message = "\(manufacturer.name), \(model.name)"
        let alert = UIAlertController(title: "Your Selection", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController.present(alert, animated: true)
    }
}
