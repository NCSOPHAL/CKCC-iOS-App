//
//  ProfileViewController.swift
//  CKCC
//
//  Created by Bun Leap on 24/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    let gender = "Male"
    let phone = "012 987 654"
    let email = "rstvu@xyz.com"
    let placeOfBirth = "Ratanakiri"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = UserDefaults.standard.value(forKey: "username") as! String
        nameLabel.text = username
        genderLabel.text = gender
        phoneLabel.text = phone
        emailLabel.text = email
        placeOfBirthLabel.text = placeOfBirth
    }
    
    
    

}
