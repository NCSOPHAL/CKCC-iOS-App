//
//  ViewController.swift
//  CKCC
//
//  Created by Bun Leap on 13/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let username = UserDefaults.standard.value(forKey: "username") as? String
        if username != nil {
            // Logged in
            print("Already logged in")
            performSegue(withIdentifier: "segue_main", sender: nil)
        }
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        
        
        //Temporary insert users
        /*
        let user1 = NSEntityDescription.insertNewObject(forEntityName: "User", into: AppDelegate.context) as! User
        user1.username = "ckcc"
        user1.password = "123"
        
        let user2 = NSEntityDescription.insertNewObject(forEntityName: "User", into: AppDelegate.context) as! User
        user2.username = "rupp"
        user2.password = "789"
        
        let user3 = NSEntityDescription.insertNewObject(forEntityName: "User", into: AppDelegate.context) as! User
        user3.username = "abc"
        user3.password = "321"
        
        let user4 = NSEntityDescription.insertNewObject(forEntityName: "User", into: AppDelegate.context) as! User
        user4.username = "xyz"
        user4.password = "456"
        
        try! AppDelegate.context.save()
    
        print("Insert 4 users")
        */
        
        
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









