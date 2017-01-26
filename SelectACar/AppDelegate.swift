//
//  AppDelegate.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/25/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var manufacturersCoordinator: ManufacturersCoordinator!

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow()
        manufacturersCoordinator = ManufacturersCoordinator(window: window!)
        manufacturersCoordinator.start()
        window!.makeKeyAndVisible()
        return true
    }
}

