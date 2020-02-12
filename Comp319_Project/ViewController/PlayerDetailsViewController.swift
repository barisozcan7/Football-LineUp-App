//
//  PlayerDetailsViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension PlayerDetailsViewController: UserDataSourceDelegate {
    func userListLoaded(userList: [User]) {
    }
}

extension UIColor {
    convenience init(hexString3: String) {
        let hex = hexString3.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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

class PlayerDetailsViewController: UIViewController {
    @IBOutlet weak var chooseOtherPlayerToCompareButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var compareButton: UIButton!
    var selectedPlayer: Player?
    let playerDataSource = PlayerDataSource()
    let userDataSource = UserDataSource()
    var players: [Player] = []
    var selectedPlayers: [Player] = []
    var selectedFormation: String?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dribblingLabel: UILabel!
    @IBOutlet weak var physicalLabel: UILabel!
    @IBOutlet weak var passingLabel: UILabel!
    @IBOutlet weak var shootingLabel: UILabel!
    @IBOutlet weak var defendingLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    var fromFormations: Int?
    var lineUpOrComparison: Int?
    var selectedPosition: Int?
    let myBlue = UIColor(hexString3: "#23C9FF")
    let myGreen = UIColor(hexString3: "#59CD90")
    let myRed = UIColor(hexString3: "#EE6352")
    let myYellow = UIColor(hexString3: "#FAC05E")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Player Details"
        userDataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let player = selectedPlayer {
            nameLabel.text = player.name
            ratingLabel.text = "Rating: \(player.overallRating)"
            positionLabel.text = playerDataSource.positionIDToPositionString(positionID: player.positionID)
            paceLabel.text = "Pace: \(player.pace)"
            dribblingLabel.text = "Dribbling: \(player.dribbling)"
            physicalLabel.text = "Physical: \(player.physical)"
            passingLabel.text = "Passing: \(player.passing)"
            shootingLabel.text = "Shooting: \(player.shooting)"
            defendingLabel.text = "Defending: \(player.defending)"
            playerImage.image = UIImage(named: "player\(player.playerID)")
            
            if(selectedPlayer?.positionID == 19) {
                paceLabel.isHidden = true
                dribblingLabel.isHidden = true
                physicalLabel.isHidden = true
                passingLabel.isHidden = true
                shootingLabel.isHidden = true
                defendingLabel.isHidden = true
            }
            if(player.positionID == 19) {
                self.view.backgroundColor = myYellow
            }
            else if(player.positionID == 20) {
                self.view.backgroundColor = myBlue
            }
            else if(player.positionID == 21) {
                self.view.backgroundColor = myGreen
            }
            else {
                self.view.backgroundColor = myRed
            }
            
            if(fromFormations == -1){
                self.chooseOtherPlayerToCompareButton.isHidden = true
                self.compareButton.isHidden = true
            }
            
            if let lineUpOrComparison = self.lineUpOrComparison{
                if(lineUpOrComparison == 0){
                    self.chooseOtherPlayerToCompareButton.isHidden = true
                    self.compareButton.setTitle("ADD TO THE LINE UP!", for: .normal)
                    
                }
            }
            if let userName = appDelegate.getUserName(){
                if let selectedPlayer = self.selectedPlayer{ userDataSource.comparisonHelper(userName: userName, selectedChild: 1, selectedPlayer: selectedPlayer)
                }}
        }
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        if let userName = appDelegate.getUserName(){
            if let selectedPlayer = self.selectedPlayer{ userDataSource.comparisonHelper(userName: userName, selectedChild: 0, selectedPlayer: selectedPlayer)
            }}
        let  vc =  self.navigationController?.viewControllers.filter({$0 is PlayerSelectionViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
    
    @IBAction func compare(_ sender: Any) {
        if(self.compareButton.title(for: .normal) == "ADD TO THE LINE UP!"){
            if let userName = appDelegate.getUserName(){
                if let selectedPosition = self.selectedPosition{
                    if let selectedFormation = self.selectedFormation{
                        if let selectedPlayer = self.selectedPlayer{
                            userDataSource.addToTheLineUp(userName: userName, selectedFormation: selectedFormation, selectedPosition: selectedPosition, selectedPlayer: selectedPlayer)
                            
                            var vc = self.navigationController?.viewControllers.filter({$0 is FourTwoThreeOneViewController}).first
                            
                            if(selectedFormation.elementsEqual("SelectedFourFourTwo")){
                                vc = self.navigationController?.viewControllers.filter({$0 is FourFourTwoViewController}).first
                            }
                            else if (selectedFormation.elementsEqual("SelectedThreeFiveTwo")){
                                vc = self.navigationController?.viewControllers.filter({$0 is ThreeFiveTwoViewController}).first
                            }
                            let seconds = 0.3
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                self.navigationController?.popToViewController(vc!, animated: true)
                            }
                        }}
                }
            }
        }
        else{
            self.performSegue(withIdentifier: "goToComparison", sender: self)
        }
    }
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}

