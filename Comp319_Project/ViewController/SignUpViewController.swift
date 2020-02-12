//
//  SignUpViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 12.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension SignUpViewController: UserDataSourceDelegate {
    func userListLoaded(userList: [User]) {
        self.userArray = userList
    }
}

class SignUpViewController: UIViewController,UITextFieldDelegate {
    var userArray: [User] = []
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var warningLabel: UILabel!
    let userDataSource = UserDataSource()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        userDataSource.delegate = self
        userDataSource.loadListOfUsers()
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        self.title = "Sign Up"
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if let password = passwordTextField.text, let confirmedPassword = confirmPasswordTextField.text, let userName = userNameTextField.text{
            
            if(userArray.filter {
                $0.userName.elementsEqual(userName)
            }.count == 1){
                warningLabel.text = "There is already a user called \(userName)"
                warningLabel.isHidden = false
                return
            }
            
            if(password.count < 5){
                warningLabel.text = "Password must be at least five characters!"
                warningLabel.isHidden = false
                return
            }
            if(password.elementsEqual(confirmedPassword)){
                userDataSource.createUser(userName: userName, password: password, selectedChild: self.userArray.count)
                appDelegate.setUserName(userName: userName)
                appDelegate.setPassword(password: password)
                let userID = "\(self.userArray.count)"
                appDelegate.setUserID(userID: userID)
                UserDefaults.standard.set(userName, forKey: "userName")
                UserDefaults.standard.set(password, forKey: "password")
                userDataSource.initializeFormations()
                userDataSource.initializeComparison()
                self.performSegue(withIdentifier: "signUpToMain", sender: self)
            }
            else {
                warningLabel.text = "Passwords don't match!"
                warningLabel.isHidden = false
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if(passwordTextField.text != "Password"){
            passwordTextField.isSecureTextEntry = true
        }
        if(confirmPasswordTextField.text != "Confirm password"){
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}

