//
//  ViewController.swift
//  CKCC
//
//  Created by Bun Leap on 13/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let username = "ckcc"
    let password = "123"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let username = UserDefaults.standard.value(forKey: "username") as? String
        if username != nil {
            // Logged in
            print("Already logged in")
            performSegue(withIdentifier: "segue_main", sender: nil)
        }
    }

    @IBAction func loginButtonClick() {
        let inputUsername = usernameTextField.text!
        let inputPassword = passwordTextField.text!
        
        if login(withUsername: inputUsername, andPassword: inputPassword) {
            performSegue(withIdentifier: "segue_main", sender: nil)
            // Save username
            UserDefaults.standard.set(inputUsername, forKey: "username")
            UserDefaults.standard.synchronize()
            print("Save username")
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

