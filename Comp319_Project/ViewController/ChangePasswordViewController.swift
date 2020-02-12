//
//  ChangePasswordViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 18.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension ChangePasswordViewController: UserDataSourceDelegate {
    func userListLoaded(userList: [User]) {
    }
}
class ChangePasswordViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let userDataSource = UserDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmNewPasswordTextField.delegate = self
        userDataSource.delegate = self
    }
    
    @IBAction func applyChanges(_ sender: Any) {
        if let currentPassword = currentPasswordTextField.text, let newPassword = newPasswordTextField.text, let confirmNewPassword = confirmNewPasswordTextField.text{
            if(!currentPassword.elementsEqual(appDelegate.getPassword()!)){
                warningLabel.text = "Wrong password!"
                warningLabel.isHidden = false
                return
            }
            if(newPassword.count < 5){
                warningLabel.text = "Password must be at least five characters!"
                warningLabel.isHidden = false
                return
            }
            if(newPassword.elementsEqual(confirmNewPassword)){
                userDataSource.changePassword(newPassword: newPassword)
                
                warningLabel.text = "Password has been changed!"
                warningLabel.isHidden = false
                
            }
            else {
                warningLabel.text = "Passwords don't match!"
                warningLabel.isHidden = false
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.isSecureTextEntry = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmNewPasswordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmNewPasswordTextField.resignFirstResponder()
        return true
    }
}
