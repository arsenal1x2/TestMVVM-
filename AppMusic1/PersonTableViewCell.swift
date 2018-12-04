//
//  PersonTableViewCell.swift
//  AppMusic1
//
//  Created by LTT on 12/4/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(person: PersonViewModel) {
        nameLabel.text = person.nameText
        ageLabel.text = person.ageText
    }

}
