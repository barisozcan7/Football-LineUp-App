//
//  AppDelegate.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 30.11.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var currentUserName: String?
    private var currentPassword: String?
    private var currentUserID: String?

    func getUserName() ->String?{
        return currentUserName
    }
    
    func setUserName(userName: String){
        currentUserName = userName
    }
    
    func getPassword() -> String?{
        return currentPassword
    }
    func setPassword(password: String){
        currentPassword = password
    }
    func getUserID() -> String?{
        return currentUserID
    }
    func setUserID(userID: String?){
        currentUserID = userID
    }
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

