//
//  CheckBox.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 17.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    let checkedImage = UIImage(named: "checked_checkbox")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked_checkbox")! as UIImage
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
