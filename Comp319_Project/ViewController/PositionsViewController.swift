//
//  PositionsViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension PositionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positionDataSource.positionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PositionCell", for: indexPath) as! PositionTableViewCell
        let index = indexPath.row.quotientAndRemainder(dividingBy: 5).remainder
        let position = positionDataSource.positionArray[index]
        
        cell.nameLabel.text = position.Name.uppercased()
        
        if(index == 0) {
            cell.backgroundColor = myYellow
        }
        else if(index == 1) {
            cell.backgroundColor = myBlue
        }
        else if(index == 2) {
            cell.backgroundColor = myGreen
        }
        else {
            cell.backgroundColor = myRed
        }
        
        return cell
    }
    
}

class PositionsViewController: UIViewController {
    
    let positionDataSource = PositionDataSource()
    var lineUpOrComparison: Int?
    var selectedPosition: Int?
    var selectedFormation: String?
    @IBOutlet weak var positionsTableView: UITableView!
    let myBlue = UIColor(hexString3: "#23C9FF")
    let myGreen = UIColor(hexString3: "#59CD90")
    let myRed = UIColor(hexString3: "#EE6352")
    let myYellow = UIColor(hexString3: "#FAC05E")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Position Selection"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! PositionTableViewCell
        let indexPath = positionsTableView.indexPath(for: cell)
        
        if let indexPath = indexPath {
            let index = indexPath.row.quotientAndRemainder(dividingBy: 5).remainder
            let position = positionDataSource.positionArray[index]
            
            let destination = segue.destination as! PlayersViewController
            self.dismiss(animated: true)
            
            destination.selectedListID = position.ID
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
