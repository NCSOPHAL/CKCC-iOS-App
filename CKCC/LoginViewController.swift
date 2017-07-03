//
//  ViewController.swift
//  CKCC
//
//  Created by Bun Leap on 13/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import CoreData

import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        let username = UserDefaults.standard.value(forKey: "username") as? String
        if username != nil {
            // Logged in
            print("Already logged in")
            performSegue(withIdentifier: "segue_main", sender: nil)
        }*/
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        if FBSDKAccessToken.current() == nil {
            // Set fb login permissions and delegate to login button
            fbLoginButton.readPermissions = ["email", "user_birthday", "user_friends", "user_hometown"]
            fbLoginButton.delegate = self
            FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        }else{
            print("User is already logged in")
            performSegue(withIdentifier: "segue_main", sender: nil)
        }
        
    }
    
    func onFacebookProfileChanged() {
        print("onFacebookProfileChanged")
    }
    
    // Login button delegate functions
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Login completed")
        if FBSDKAccessToken.current() != nil {
            let profile = FBSDKProfile.current()
            print("Name: ", profile?.name)
            performSegue(withIdentifier: "segue_main", sender: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
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
            
            // Insert login history
            let loginHistory = NSEntityDescription.insertNewObject(forEntityName: "LoginHistory", into: AppDelegate.context) as! LoginHistory
            loginHistory.username = inputUsername
            loginHistory.time = NSDate()
            try! AppDelegate.context.save()
        } else {
            print("Invalid username or password")
        }
        
    }
    
    func login(withUsername username : String, andPassword password: String) -> Bool {
        let request = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "username = %@ and password = %@", username, password)
        request.predicate = predicate
        let users = try! AppDelegate.context.fetch(request)
        if users.count > 0 {
            return true
        }else{
            return false
        }
    }
    
    func test() {
        var message = "Hello world"
        var title : String?
        var newTitle = title!
    }

}









