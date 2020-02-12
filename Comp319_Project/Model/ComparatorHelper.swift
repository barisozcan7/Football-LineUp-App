//
//  CompareHelper.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 3.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol ComparatorHelperDelegate {
    func selectedPlayerListLoaded (selectedPlayerList: [Player])
}

extension ComparatorHelperDelegate {
    func selectedPlayerListLoaded (selectedPlayerList: [Player]) { }
}

class ComparatorHelper {
    var delegate: ComparatorHelperDelegate?
    let myURL = "https://football-players-app.firebaseio.com"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadListOfSelectedPlayers() {
        if let userName = appDelegate.getUserName(){
            
            let session = URLSession.shared
            
            if let url = URL(string: "\(myURL)/\(userName)SelectedPlayers.json") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    
                    let decoder = JSONDecoder()
                    let selectedPlayerList = try! decoder.decode([Player].self, from: data!)
                    
                    DispatchQueue.main.async {            self.delegate?.selectedPlayerListLoaded(selectedPlayerList: selectedPlayerList)
                    }
                }
                dataTask.resume()
            }
        }
    }
}
