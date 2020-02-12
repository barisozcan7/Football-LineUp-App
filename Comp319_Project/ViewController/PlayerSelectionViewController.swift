//
//  PlayerSelectionViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 11.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

class PlayerSelectionViewController: UIViewController {
    var lineUpOrComparison: Int?
    var selectedPosition: Int?
    var selectedFormation: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Player Selection"
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.black;
    }
    
    @IBAction func listTeams(_ sender: Any) {
        self.performSegue(withIdentifier: "listTeams", sender: self)
    }
    
    @IBAction func listPositions(_ sender: Any) {
        self.performSegue(withIdentifier: "listPositions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listTeams"){
            
            let destination = segue.destination as! TeamsViewController
            self.dismiss(animated: true)
            
            destination.lineUpOrComparison = self.lineUpOrComparison
            destination.selectedPosition = self.selectedPosition
            destination.selectedFormation = self.selectedFormation
        }
        else{
            let destination = segue.destination as! PositionsViewController
            self.dismiss(animated: true)
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
