//
//  MenuViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 17.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        weak var pvc:UIViewController! = self.presentingViewController?.children[1]
        
        dismiss(animated: true) {
            if(index == 1){
                pvc.performSegue(withIdentifier: "changePassword", sender: self)
            }
            else if(index == 2){
                pvc.performSegue(withIdentifier: "menuToInfo", sender: self)
            }
            else if(index == 3){
                UserDefaults.standard.removeObject(forKey: "userName")
                UserDefaults.standard.removeObject(forKey: "password")
                pvc.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true) {}
    }
}
