//
//  InMemoryManufacturersInteractor.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class InMemoryManufacturersInteractor: ManufacturersInteractor {
    let data = [
        DefaultManufacturer(id: 1, name: "Adler"),
        DefaultManufacturer(id: 2, name: "Amphicar"),
        DefaultManufacturer(id: 3, name: "Artega"),
        DefaultManufacturer(id: 4, name: "Audi"),
        DefaultManufacturer(id: 5, name: "Auto-Union"),
        DefaultManufacturer(id: 6, name: "Apal"),
        DefaultManufacturer(id: 7, name: "Artega Automobil GmbH"),
        DefaultManufacturer(id: 8, name: "AWZ-Zwickau"),
        DefaultManufacturer(id: 9, name: "BUS"),
        DefaultManufacturer(id: 10, name: "B+B"),
        DefaultManufacturer(id: 11, name: "Bitter"),
        DefaultManufacturer(id: 12, name: "BMW"),
        DefaultManufacturer(id: 13, name: "Borgward"),
        DefaultManufacturer(id: 14, name: "Brennabor-Werke"),
        DefaultManufacturer(id: 15, name: "Brütsch"),
        DefaultManufacturer(id: 16, name: "Champion"),
        DefaultManufacturer(id: 17, name: "Daimler"),
        DefaultManufacturer(id: 18, name: "Dauer"),
        DefaultManufacturer(id: 19, name: "Dürkopp"),
        DefaultManufacturer(id: 20, name: "Dixi"),
        DefaultManufacturer(id: 21, name: "DKW"),
        DefaultManufacturer(id: 22, name: "Espenlaub"),
        DefaultManufacturer(id: 23, name: "Fafnir"),
        DefaultManufacturer(id: 24, name: "Fuldamobil"),
        DefaultManufacturer(id: 25, name: "Glas"),
        DefaultManufacturer(id: 26, name: "Goggomobil"),
        DefaultManufacturer(id: 27, name: "Goliath"),
        DefaultManufacturer(id: 28, name: "Gumpert"),
        DefaultManufacturer(id: 29, name: "Gutbrod"),
        DefaultManufacturer(id: 30, name: "Hanomag"),
        DefaultManufacturer(id: 31, name: "Heinkel"),
        DefaultManufacturer(id: 32, name: "Horch"),
        DefaultManufacturer(id: 33, name: "Irmscher"),
        DefaultManufacturer(id: 34, name: "Isdera"),
        DefaultManufacturer(id: 35, name: "Karmann"),
        DefaultManufacturer(id: 36, name: "Kleinschnittger"),
        DefaultManufacturer(id: 37, name: "Koenig"),
        DefaultManufacturer(id: 38, name: "Lloyd"),
        DefaultManufacturer(id: 39, name: "Lotec"),
        DefaultManufacturer(id: 40, name: "Lutzmann"),
        DefaultManufacturer(id: 41, name: "Magna Steyr"),
        DefaultManufacturer(id: 42, name: "Maico"),
        DefaultManufacturer(id: 43, name: "Maybach"),
        DefaultManufacturer(id: 44, name: "MCC"),
        DefaultManufacturer(id: 45, name: "Melkus"),
        DefaultManufacturer(id: 46, name: "Mercedes-Benz"),
        DefaultManufacturer(id: 47, name: "Messerschmitt"),
        DefaultManufacturer(id: 48, name: "Markranstädter Automobilfabrik"),
        DefaultManufacturer(id: 49, name: "NAG"),
        DefaultManufacturer(id: 50, name: "NSU"),
        DefaultManufacturer(id: 51, name: "Opel"),
        DefaultManufacturer(id: 52, name: "Pinguin"),
        DefaultManufacturer(id: 53, name: "Porsche"),
        DefaultManufacturer(id: 54, name: "Ruf Automobile GmbH"),
        DefaultManufacturer(id: 55, name: "Rumpler"),
        DefaultManufacturer(id: 56, name: "Smart"),
        DefaultManufacturer(id: 57, name: "Stoewer"),
        DefaultManufacturer(id: 58, name: "Trabant"),
        DefaultManufacturer(id: 59, name: "Treser"),
        DefaultManufacturer(id: 60, name: "Vauxhall"),
        DefaultManufacturer(id: 61, name: "Victoria"),
        DefaultManufacturer(id: 62, name: "Volkswagen"),
        DefaultManufacturer(id: 63, name: "Wanderer"),
        DefaultManufacturer(id: 64, name: "Wartburg"),
        DefaultManufacturer(id: 65, name: "Wendax"),
        DefaultManufacturer(id: 66, name: "Wiesmann"),
        DefaultManufacturer(id: 67, name: "Yes!"),
        DefaultManufacturer(id: 68, name: "Zender"),
        DefaultManufacturer(id: 69, name: "Zundapp")
    ]

    func get(page: Page, completionHandler: @escaping (ManufacturersInteractorResult) -> Void) {
        DispatchQueue.main.async {
            let startIndex = page.page * page.size
            if (startIndex >= self.data.count) {
                completionHandler(.Success([]))
            } else {
                let endIndex = min(startIndex + page.size, self.data.count)
                let manufacturers = Array(self.data[startIndex..<endIndex])
                completionHandler(.Success(manufacturers))
            }
        }
    }
}

