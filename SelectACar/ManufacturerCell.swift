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

    var entity: Entity? {
        didSet {
            nameLabel.text = entity?.name
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.entity = nil
        self.backgroundColor = UIColor.white
    }
}
