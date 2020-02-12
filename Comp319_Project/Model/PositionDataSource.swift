//
//  PositionDataSource.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation

class PositionDataSource {
    var positionArray: [Position] = []
    
    init() {
        positionArray.append(Position(ID: 19, Name: "Goalkeepers"))
        positionArray.append(Position(ID: 20, Name: "Defenders"))
        positionArray.append(Position(ID: 21, Name: "Midfielders"))
        positionArray.append(Position(ID: 22, Name: "Attackers"))
    }
}
