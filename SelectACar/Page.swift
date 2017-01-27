//
//  Page.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

struct Page {
    let number: Int
    let size: Int

    func next() -> Page {
        return Page(number: number + 1, size: size)
    }
}
