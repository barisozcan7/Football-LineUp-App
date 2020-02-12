//
//  SignInViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 12.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension SignInViewController: UserDataSourceDelegate {
    func userListLoaded(userList: [User]) {
        self.userArray = userList
    }
}

class SignInViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    var userArray: [User] = []
    let userDataSource = UserDataSource()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        passwordTextField.delegate = self
        userDataSource.delegate = self
        userDataSource.loadListOfUsers()
        userNameTextField.delegate = self
        autoLogin()
        self.title = "Sign In"
   signUpLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.signUpTapped)))
        signUpLabel.isUserInteractionEnabled = true;
    }
    
    @IBAction func signIn(_ sender: Any) {
        if let password = passwordTextField.text, let userName = userNameTextField.text{
            if (userArray.contains(User(userName: userName, password: password))) {
                userNameTextField.text = ""
                passwordTextField.text = ""
                warningLabel.isHidden = true
                appDelegate.setUserName(userName: userName)
                appDelegate.setPassword(password: password)
                let userIDInt = userArray.firstIndex(of: User(userName: userName, password: password))
                let userID = "\(userIDInt!)"
                appDelegate.setUserID(userID:userID)
                if(checkBox.isChecked){
                    UserDefaults.standard.set(userName, forKey: "userName")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(userID, forKey: "userID")
                }
                else{
                    UserDefaults.standard.removeObject(forKey: "userName")
                     UserDefaults.standard.removeObject(forKey: "password")
                     UserDefaults.standard.removeObject(forKey: "userID")
                }
                self.performSegue(withIdentifier: "signInToMain", sender: self)
            }
                  else {
                      warningLabel.isHidden = false
                  }
              }
    }
    
    func autoLogin(){
        if let userName = UserDefaults.standard.string(forKey: "userName"),let password = UserDefaults.standard.string(forKey: "password"), let userID = UserDefaults.standard.string(forKey: "userID"){
            appDelegate.setUserName(userName: userName)
            appDelegate.setPassword(password: password)
            appDelegate.setUserID(userID: userID)
       self.performSegue(withIdentifier: "signInToMain", sender: self)
            }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
           if(passwordTextField.text != "Password"){
               passwordTextField.isSecureTextEntry = true
           }       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            userNameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
    }
    
    @objc func signUpTapped(){
    self.performSegue(withIdentifier: "signUp", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
