//
//  LineUpGeneratorViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 12.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

class LineUpGeneratorViewController: UIViewController {
    @IBOutlet weak var ownLineUpButton: UIButton!
    @IBOutlet weak var bestLineUpsButton: UIButton!
    var ownOrBest: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Generate Line Up"
    }
    
    @IBAction func generateOwnLineUp(_ sender: Any) {
        ownOrBest = 0
        self.performSegue(withIdentifier: "lineUpToFormation", sender: self)
    }
    
    @IBAction func showBestLineUps(_ sender: Any) {
        ownOrBest = 1
        self.performSegue(withIdentifier: "lineUpToFormation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FormationSelectionViewController
        destination.selectedOwnOrBest = ownOrBest
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}



