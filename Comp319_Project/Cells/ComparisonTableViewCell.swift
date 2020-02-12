//
//  ComparisonTableViewCell.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 9.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

class ComparisonTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dribblingLabel: UILabel!
    @IBOutlet weak var passingLabel: UILabel!
    @IBOutlet weak var shootingLabel: UILabel!
    @IBOutlet weak var physicalLabel: UILabel!
    @IBOutlet weak var defendingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
