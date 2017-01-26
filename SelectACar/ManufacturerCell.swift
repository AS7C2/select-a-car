//
//  ManufacturerCell.swift
//  SelectACar
//
//  Created by Andrei Sherstniuk on 1/26/17.
//  Copyright © 2017 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class ManufacturerCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    var manufactuer: Manufacturer? {
        didSet {
            nameLabel.text = manufactuer?.name
        }
    }
}
