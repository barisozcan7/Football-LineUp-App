//
//  TeamDataSource.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 2.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation

protocol TeamDataSourceDelegate {
    func teamListLoaded (teamList: [Team])
}

extension TeamDataSourceDelegate {
    func teamListLoaded (teamList: [Team]) { }
}

class TeamDataSource {
    var delegate: TeamDataSourceDelegate?
    let myURL = "https://football-players-app.firebaseio.com/Teams.json"
    
    func loadListOfTeams() {
        let session = URLSession.shared
        
        if let url = URL(string: "\(myURL)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                let decoder = JSONDecoder()
                if let teamData = data{
                    let teamList = try! decoder.decode([Team].self, from: teamData)
                    DispatchQueue.main.async {            self.delegate?.teamListLoaded(teamList: teamList)
                    }
                }
                else{
                    self.delegate?.teamListLoaded(teamList: [])
                }
            }
            dataTask.resume()
        }
    }
}



