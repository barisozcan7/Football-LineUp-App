//
//  UserDataSource.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 12.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UserDataSourceDelegate {
    func userListLoaded (userList: [User])
}

extension UserDataSourceDelegate {
    func userListLoaded (userList: [User]) { }
}

class UserDataSource {
    var delegate: UserDataSourceDelegate?
    let myURL = "https://football-players-app.firebaseio.com"
    var ref: DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadListOfUsers() {
        let session = URLSession.shared
        
        if let url = URL(string: "\(myURL)/Users.json") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                let decoder = JSONDecoder()
                
                if let userData = data{
                   let userList = try! decoder.decode([User].self, from: userData)
                    DispatchQueue.main.async {            self.delegate?.userListLoaded(userList: userList)
                    }
                }
                else{
                    self.delegate?.userListLoaded(userList: [])
                }
            }
            dataTask.resume()
        }
    }
    
    func initializeComparison(){
        if let userName = appDelegate.getUserName(){
            
            ref = Database.database().reference()
            self.ref.child("\(userName)SelectedPlayers").child("0").setValue(["name":"Default Player ","overallRating":-1,"playerID":-1,"positionID":-1,"teamID":-1,"dribbling": -1,"pace":-1,"physical":-1,"passing":-1,"shooting":-1,"defending":-1,"goalkeeping":-1]                )
            self.ref.child("\(userName)SelectedPlayers").child("1").setValue(["name":"Default Player ","overallRating":-1,"playerID":-1,"positionID":-1,"teamID":-1,"dribbling": -1,"pace":-1,"physical":-1,"passing":-1,"shooting":-1,"defending":-1,"goalkeeping":-1]                )
        }
    }
    
    func addToTheLineUp(userName:String, selectedFormation: String, selectedPosition: Int, selectedPlayer: Player){
    ref = Database.database().reference()
   ref.child("\(userName)\(selectedFormation)").child("\(selectedPosition - 1)").setValue(["name":selectedPlayer.name,"overallRating":selectedPlayer.overallRating,"playerID":selectedPlayer.playerID,"positionID":selectedPlayer.positionID,"teamID":selectedPlayer.teamID,"dribbling": selectedPlayer.dribbling,"pace":selectedPlayer.pace,"physical":selectedPlayer.physical,"passing":selectedPlayer.passing,"shooting":selectedPlayer.shooting,"defending":selectedPlayer.defending,"goalkeeping":selectedPlayer.goalkeeping]                )
    }
    
    func createUser(userName:String, password: String, selectedChild: Int){
    ref = Database.database().reference()
  ref.child("Users").child("\(selectedChild)").setValue(["userName": userName, "password": password])
    }
    
    func changePassword(newPassword:String){
      ref = Database.database().reference()
  ref.child("Users").child("\(appDelegate.getUserID()!)").setValue(["userName": appDelegate.getUserName(), "password": newPassword])
        
        appDelegate.setPassword(password: newPassword)

        UserDefaults.standard.set(newPassword, forKey: "password")
    }
    
    func comparisonHelper(userName: String, selectedChild: Int, selectedPlayer: Player){
        
        ref = Database.database().reference()
   ref.child("\(userName)SelectedPlayers").child("\(selectedChild)").setValue(["name":selectedPlayer.name,"overallRating":selectedPlayer.overallRating,"playerID":selectedPlayer.playerID,"positionID":selectedPlayer.positionID,"teamID":selectedPlayer.teamID,"dribbling": selectedPlayer.dribbling,"pace":selectedPlayer.pace,"physical":selectedPlayer.physical,"passing":selectedPlayer.passing,"shooting":selectedPlayer.shooting,"defending":selectedPlayer.defending,"goalkeeping":selectedPlayer.goalkeeping])
    }
    
    func initializeFormations(){
        if let userName = appDelegate.getUserName(){
            
            ref = Database.database().reference()
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("0").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("1").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("2").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("3").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("4").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("5").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("6").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("7").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("8").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("9").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourTwoThreeOne").child("10").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("0").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("1").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("2").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("3").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("4").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("5").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("6").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("7").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("8").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("9").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedFourFourTwo").child("10").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("0").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("1").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("2").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("3").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("4").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("5").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("6").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("7").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("8").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("9").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
            self.ref.child("\(userName)SelectedThreeFiveTwo").child("10").setValue(["name":"A ","overallRating":0,"playerID":0,"positionID":0,"teamID":0,"dribbling": 0,"pace":0,"physical":0,"passing":0,"shooting":0,"defending":0,"goalkeeping":0])
        }
    }
}

