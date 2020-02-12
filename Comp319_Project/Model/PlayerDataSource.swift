//
//  PlayerDataSource.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 2.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation
import FirebaseDatabase
protocol PlayerDataSourceDelegate {
    func playerListLoaded (playerList: [Player])
    func playerListLoadedFor4231 (playerList: [Player])
    func playerListLoadedFor442 (playerList: [Player])
    func playerListLoadedFor352 (playerList: [Player])
}

extension PlayerDataSourceDelegate {
    func playerListLoaded (playerList: [Player]) { }
    func playerListLoadedFor4231 (playerList: [Player]) { }
    func playerListLoadedFor442 (playerList: [Player]) { }
    func playerListLoadedFor352 (playerList: [Player]) { }
}

class PlayerDataSource {
    var delegate: PlayerDataSourceDelegate?
    let myURL = "https://football-players-app.firebaseio.com"
    var ref: DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadListOfPlayers() {
        let session = URLSession.shared
        
        if let url = URL(string: "\(myURL)/Players.json") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                let decoder = JSONDecoder()
                if let playerData = data{
                    let playerList = try! decoder.decode([Player].self, from: playerData)
                    DispatchQueue.main.async {            self.delegate?.playerListLoaded(playerList: playerList)
                    }
                }
                else{
                    self.delegate?.playerListLoaded(playerList: [])
                }
            }
            dataTask.resume()
        }
    }
    
    func loadListOfPlayersFor4231() {
        if let userName = appDelegate.getUserName(){
            let session = URLSession.shared
            
            if let url = URL(string: "\(myURL)/\(userName)SelectedFourTwoThreeOne.json") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    
                    let decoder = JSONDecoder()
                    if let playerData = data{
                        let playerList = try! decoder.decode([Player].self, from: playerData)
                        DispatchQueue.main.async {            self.delegate?.playerListLoadedFor4231(playerList: playerList)
                        }
                    }
                    else{
                    self.delegate?.playerListLoadedFor4231(playerList: [])
                    }
                }
                dataTask.resume()
            }
        }
    }
    
    func loadListOfPlayersFor442() {
        if let userName = appDelegate.getUserName(){
            let session = URLSession.shared
            
            if let url = URL(string: "\(myURL)/\(userName)SelectedFourFourTwo.json") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    
                    let decoder = JSONDecoder()
                    if let playerData = data{
                        let playerList = try! decoder.decode([Player].self, from: playerData)
                        DispatchQueue.main.async {            self.delegate?.playerListLoadedFor442(playerList: playerList)
                        }
                    }
                    else{
                self.delegate?.playerListLoadedFor442(playerList: [])
                    }
                }
                dataTask.resume()
            }
        }
    }
    func loadListOfPlayersFor352() {
        if let userName = appDelegate.getUserName(){
            
            let session = URLSession.shared
            
            if let url = URL(string: "\(myURL)/\(userName)SelectedThreeFiveTwo.json") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    
                    let decoder = JSONDecoder()
                    if let playerData = data{
                        let playerList = try! decoder.decode([Player].self, from: playerData)
                        DispatchQueue.main.async {            self.delegate?.playerListLoadedFor352(playerList: playerList)
                        }
                    }
                    else{
                self.delegate?.playerListLoadedFor352(playerList: [])
                    }
                }
                dataTask.resume()
            }
        }
    }
    
    func positionIDToPositionString(positionID: Int) -> String {
        switch positionID {
        case 19:
            return "Goalkeeper"
        case 20:
            return "Defender"
        case 21:
            return "Midfielder"
        default:
            return "Attacker"
        }
    }
    
    func teamIDToTeamString(teamID: Int) -> String {
        switch teamID {
        case 1:
            return "Galatasaray"
        case 2:
            return "Fenerbahce"
        case 3:
            return "Besiktas"
        case 4:
            return "Trabzonspor"
        case 5:
            return "Ankaragucu"
        case 6:
            return "Sivasspor"
        case 7:
            return "Basaksehir FK"
        case 8:
            return "Alanyaspor"
        case 9:
            return "Malatyaspor"
        case 10:
            return "Goztepe"
        case 11:
            return "Denizlispor"
        case 12:
            return "Rizespor"
        case 13:
            return "Gaziantep FK"
        case 14:
            return "Konyaspor"
        case 15:
            return "Genclerbirligi"
        case 16:
            return "Kasimpasa"
        case 17:
            return "Antalyaspor"
        default:
            return "Kayserispor"
        }
    }
    
}
















