//
//  ManufacturersCoordinator.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ManufacturersCoordinator {
    let window: UIWindow
    var navigationController: UINavigationController!
    var selectCarInteractor: SelectCarInteractor!
    var modelsCoordinator: ModelsCoordinator!

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Manufacturers")
                as! ManufacturersViewController
        self.selectCarInteractor = SelectCarInteractor()
        let urlBuilder = ManufacturersPagedURLBuilder(
                configuration: DefaultWebConfiguration(),
                path: "/v1/car-types/manufacturer")
        let presenter = DefaultManufacturersPresenter(
                title: "Manufacturers",
                manufacturersInteractor: WebManufacturersInteractor(
                        urlBuilder: urlBuilder,
                        entityFactory: ManufacturerFactory()),
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: selectCarInteractor))
        selectCarInteractor.selectCarManufacturerDelegate = self
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension ManufacturersCoordinator: SelectCarManufacturerDelegate {
    func selectCarInteractor(_ interactor: SelectCarInteractor, didSelectManufacturer manufacturer: Manufacturer) {
        modelsCoordinator = ModelsCoordinator(
                navigationController: navigationController,
                selectCarInteractor: selectCarInteractor)
        modelsCoordinator.start()
    }
}
