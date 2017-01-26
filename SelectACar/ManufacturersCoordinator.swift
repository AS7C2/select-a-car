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
                as! ManufacturersTableViewController
        let presenter = DefaultManufacturersPresenter(interactor: InMemoryManufacturersInteractor())
        presenter.viewDelegate = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}
