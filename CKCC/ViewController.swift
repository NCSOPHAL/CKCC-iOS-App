//
//  ViewController.swift
//  CKCC
//
//  Created by Bun Leap on 13/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let username = "ckcc"
    let password = "123"

    @IBAction func loginButtonClick() {
        let inputUsername = usernameTextField.text!
        let inputPassword = passwordTextField.text!
        
        if login(withUsername: inputUsername, andPassword: inputPassword) {
            performSegue(withIdentifier: "segue_main", sender: nil)
        } else {
            print("Invalid username or password")
        }
        
    }
    
    func login(withUsername username : String, andPassword password: String) -> Bool {
        if username == self.username && password == self.password {
            return true
        } else {
            return false
        }
    }

}

