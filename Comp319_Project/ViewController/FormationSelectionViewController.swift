//
//  FormationSelectionViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

class FormationSelectionViewController: UIViewController {
    var selectedFormation: Int?
    var selectedOwnOrBest: Int?
    @IBOutlet weak var button4231: UIButton!
    @IBOutlet weak var button442: UIButton!
    @IBOutlet weak var button352: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Select Formation"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is FourFourTwoViewController){
            let destination = segue.destination as! FourFourTwoViewController
            destination.selectedOwnOrBest = selectedOwnOrBest
        }
        
        if(segue.destination is FourTwoThreeOneViewController){
            let destination = segue.destination as! FourTwoThreeOneViewController
            destination.selectedOwnOrBest = selectedOwnOrBest
        }
        
        if(segue.destination is ThreeFiveTwoViewController){
            let destination = segue.destination as! ThreeFiveTwoViewController
            destination.selectedOwnOrBest = selectedOwnOrBest
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}



