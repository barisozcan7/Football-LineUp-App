//
//  TeamsViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension TeamsViewController: TeamDataSourceDelegate {
    func teamListLoaded(teamList: [Team]) {
        self.teamArray = teamList.sorted { $0.Name < $1.Name }
        self.currentTeamArray = self.teamArray
        self.teamsTableView.reloadData()
    }
}

extension TeamsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTeamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamTableViewCell
        let index = indexPath.row
        let team = currentTeamArray[index]
  
        cell.nameLabel.text = team.Name.uppercased()
        cell.teamImage.image = UIImage(named: team.ImageID)
        
        return cell
    }
    
}

class TeamsViewController: UIViewController, UISearchBarDelegate {
    var teamArray: [Team] = []
    let teamDataSource = TeamDataSource()
    var lineUpOrComparison: Int?
    var selectedPosition: Int?
    var selectedFormation: String?
    var currentTeamArray: [Team] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var teamsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        teamDataSource.delegate = self
        teamDataSource.loadListOfTeams()
        searchBar.placeholder = "Search team by name!"
        showSearchBar()
         self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Team Selection"
    }
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search team by name!"
        navigationItem.searchController = searchController
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        searchBar.text = ""
        searchBar.showsCancelButton = false
        currentTeamArray = teamArray
        searchBar.endEditing(true)
        self.teamsTableView.reloadData()
        searchBar.placeholder = "Search team by name!"
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentTeamArray = teamArray
            self.teamsTableView.reloadData()
            return
        }
        currentTeamArray = teamArray.filter( { team -> Bool in
            return team.Name.lowercased().contains(searchText.lowercased())
        })
        self.teamsTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! TeamTableViewCell
        
        let indexPath = teamsTableView.indexPath(for: cell)
        
        if let indexPath = indexPath {
            let index = indexPath.row
            let team = currentTeamArray[index]
            
            let destination = segue.destination as! PlayersViewController
            self.dismiss(animated: true)

            destination.selectedListID = team.ID
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
