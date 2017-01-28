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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Manufacturers")
                as! ManufacturersViewController
        let selectCarInteractor = SelectCarInteractor()
        let presenter = DefaultManufacturersPresenter(
                manufacturersInteractor: WebManufacturersInteractor(configuration: DefaultWebConfiguration()),
                entitySelectionStrategy: ManufacturerSelectionStrategy(interactor: selectCarInteractor))
        selectCarInteractor.selectCarManufacturerDelegate = presenter
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension ModelsCoordinator: ManufacturersPresenterCoordinatorDelegate {
    func manufacturersPresenter(_ presenter: ManufacturersPresenter, didSelectManufacturer manufacturer: Entity) {

    }
}
