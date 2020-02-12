//
//  Player.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation

struct Player: Codable {
    let playerID: Int
    let name: String
    let teamID: Int
    let positionID: Int
    let overallRating: Int
    let pace: Int
    let shooting: Int
    let passing: Int
    let dribbling: Int
    let physical: Int
    let defending: Int
    let goalkeeping: Int
}
