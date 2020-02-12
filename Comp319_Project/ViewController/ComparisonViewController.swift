//
//  ComparisonViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString4: String) {
        let hex = hexString4.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension ComparisonViewController: ComparatorHelperDelegate {
    func selectedPlayerListLoaded(selectedPlayerList: [Player]) {
        self.selectedPlayers = selectedPlayerList
        // I make the program wait to reload data
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.comparisonTableView.reloadData()
        }
    }
}

extension ComparisonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComparisonCell", for: indexPath) as! ComparisonTableViewCell
        let index = indexPath.row.quotientAndRemainder(dividingBy: 2).remainder
        let player = selectedPlayers[index]
        
        if(player.playerID == -1){
            cell.nameLabel.isHidden = true
            cell.ratingLabel.isHidden = true
            cell.positionLabel.isHidden = true
            cell.playerImage.isHidden = true
            cell.paceLabel.isHidden = true
            cell.dribblingLabel.isHidden = true
            cell.physicalLabel.isHidden = true
            cell.passingLabel.isHidden = true
            cell.shootingLabel.isHidden = true
            cell.defendingLabel.isHidden = true
        }
        
        cell.nameLabel.text = player.name
        cell.ratingLabel.text = "Rating: \(player.overallRating)"
        cell.positionLabel.text = self.playerDataSource.positionIDToPositionString(positionID: player.positionID)
        cell.paceLabel.text = "Pace: \(player.pace)"
        cell.dribblingLabel.text = "Dribbling: \(player.dribbling)"
        cell.physicalLabel.text = "Physical: \(player.physical)"
        cell.passingLabel.text = "Passing: \(player.passing)"
        cell.shootingLabel.text = "Shooting: \(player.shooting)"
        cell.defendingLabel.text = "Defending: \(player.defending)"
        cell.playerImage.image = UIImage(named: "player\(player.playerID)")
        
        if(player.positionID == 19) {
            cell.backgroundColor = myYellow
        }
        else if(player.positionID == 20) {
            cell.backgroundColor = myBlue
        }
        else if(player.positionID == 21) {
            cell.backgroundColor = myGreen
        }
        else {
            cell.backgroundColor = myRed
        }
        
        if(index == 0){
            let otherPlayer = selectedPlayers[1]
            if(player.overallRating > otherPlayer.overallRating){
                cell.ratingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.pace > otherPlayer.pace){
                cell.paceLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.dribbling > otherPlayer.dribbling){
                cell.dribblingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.physical > otherPlayer.physical){
                cell.physicalLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.passing > otherPlayer.passing){
                cell.passingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.shooting > otherPlayer.shooting){
                cell.shootingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.defending > otherPlayer.defending){
                cell.defendingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
        }
        else{
            let otherPlayer = selectedPlayers[0]
            if(player.overallRating > otherPlayer.overallRating){
                cell.ratingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.pace > otherPlayer.pace){
                cell.paceLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.dribbling > otherPlayer.dribbling){
                cell.dribblingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.physical > otherPlayer.physical){
                cell.physicalLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.passing > otherPlayer.passing){
                cell.passingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.shooting > otherPlayer.shooting){
                cell.shootingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            if(player.defending > otherPlayer.defending){
                cell.defendingLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
        }
        if(player.positionID == 19) {
            cell.paceLabel.isHidden = true
            cell.dribblingLabel.isHidden = true
            cell.physicalLabel.isHidden = true
            cell.passingLabel.isHidden = true
            cell.shootingLabel.isHidden = true
            cell.defendingLabel.isHidden = true
        }
        
        return cell
    }
    
}

extension UIColor {
    convenience init(hexString2: String) {
        let hex = hexString2.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class ComparisonViewController: UIViewController {
    let playerDataSource = PlayerDataSource()
    var selectedPlayers : [Player] = []
    let comparatorHelper = ComparatorHelper()
    let myBlue = UIColor(hexString2: "#23C9FF")
    let myGreen = UIColor(hexString2: "#59CD90")
    let myRed = UIColor(hexString2: "#EE6352")
    let myYellow = UIColor(hexString2: "#FAC05E")
    @IBOutlet weak var comparisonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comparatorHelper.delegate = self
        comparatorHelper.loadListOfSelectedPlayers()
        self.navigationController!.navigationBar.tintColor = UIColor.black;
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}


