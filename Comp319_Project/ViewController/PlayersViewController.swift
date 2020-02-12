//
//  PlayersViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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

extension PlayersViewController: PlayerDataSourceDelegate {
    func playerListLoaded(playerList: [Player]) {
        self.playerArray = playerList.sorted{
            $0.overallRating > $1.overallRating
        }.sorted{
            $0.positionID < $1.positionID
        }
        self.currentPlayerArray = self.playerArray
        self.playersTableView.reloadData()
    }
}

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let playersArray = currentPlayerArray.filter {
            $0.teamID == selectedListID || $0.positionID == selectedListID
        }
        return playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playersArray = currentPlayerArray.filter {
            $0.teamID == selectedListID || $0.positionID == selectedListID
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        let index = indexPath.row
        let player = playersArray[index]
        
        cell.nameLabel.text = player.name
        cell.teamLabel.text = playerDataSource.teamIDToTeamString(teamID: player.teamID)
        cell.positionLabel.text = playerDataSource.positionIDToPositionString(positionID: player.positionID)
        cell.ratingLabel.text = "Rating: \(player.overallRating)"
        
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
        return cell
    }
}

class PlayersViewController: UIViewController, UISearchBarDelegate {
    var playerArray: [Player] = []
    var currentPlayerArray: [Player] = []
    var selectedListID: Int?
    let playerDataSource = PlayerDataSource()
    var lineUpOrComparison: Int?
    var selectedPosition: Int?
    var selectedFormation: String?
    let myBlue = UIColor(hexString: "#23C9FF")
    let myGreen = UIColor(hexString: "#59CD90")
    let myRed = UIColor(hexString: "#EE6352")
    let myYellow = UIColor(hexString: "#FAC05E")
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDataSource.delegate = self
        playerDataSource.loadListOfPlayers()
        searchBar.placeholder = "Search player by name!"
        showSearchBar()
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Players"
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search player by name!"
        navigationItem.searchController = searchController
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        searchBar.text = ""
        searchBar.showsCancelButton = false
        currentPlayerArray = playerArray
        searchBar.endEditing(true)
        self.playersTableView.reloadData()
        searchBar.placeholder = "Search player by name!"
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentPlayerArray = playerArray
            self.playersTableView.reloadData()
            return
        }
        currentPlayerArray = playerArray.filter( { player -> Bool in
            return player.name.lowercased().contains(searchText.lowercased())
        })
        
        self.playersTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! PlayerTableViewCell
        
        let indexPath = playersTableView.indexPath(for: cell)
        
        if let indexPath = indexPath {
            let index = indexPath.row
            
            let player = currentPlayerArray.filter {
                $0.teamID == selectedListID || $0.positionID == selectedListID
                }[index]
            
            let destination = segue.destination as! PlayerDetailsViewController
            self.dismiss(animated: true)
            
            destination.selectedPlayer = player
            destination.lineUpOrComparison = self.lineUpOrComparison
            destination.selectedPosition = self.selectedPosition
            destination.selectedFormation = self.selectedFormation
            
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}
