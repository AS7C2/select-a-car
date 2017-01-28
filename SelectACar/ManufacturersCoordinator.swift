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

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Manufacturers")
                as! ManufacturersViewController
        let selectCarInteractor = SelectCarInteractor()
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: WebManufacturersInteractor(
                        configuration: DefaultWebConfiguration(),
                        entityFactory: ManufactorerFactory()),
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: selectCarInteractor))
        selectCarInteractor.selectCarManufacturerDelegate = presenter
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension ManufacturersCoordinator: ManufacturersPresenterCoordinatorDelegate {
    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didSelectManufacturer manufacturer: Entity) {
        let modelsCoordinator = ModelsCoordinator(navigationController: navigationController)
        modelsCoordinator.start()
    }
}
