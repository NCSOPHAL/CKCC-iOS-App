//
//  ProfileViewController.swift
//  CKCC
//
//  Created by Bun Leap on 24/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    @IBOutlet weak var profileLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileLoadingIndicator.isHidden = false
        let url = URL(string: "http://test.js-cambodia.com/ckcc/profile.json")!
        let requestTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let profile = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            let name = profile["name"] as! String
            let gender = profile["gender"] as! String
            let phone = profile["phone"] as! String
            let email = profile["email"] as! String
            let pob = profile["pob"] as! String
            let imageUrl = profile["profile_image"] as! String
            
            self.nameLabel.text = name
            self.genderLabel.text = gender
            self.phoneLabel.text = phone
            self.emailLabel.text = email
            self.placeOfBirthLabel.text = pob
            
            self.profileLoadingIndicator.isHidden = true
            self.showImageFromServer(imageUrl: imageUrl)
        }
        requestTask.resume()
    }
    
    func showImageFromServer(imageUrl: String) {
        let url = URL(string: imageUrl)!
        let imageTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let image = UIImage(data: data!)
            self.profileImageView.image = image
        }
        imageTask.resume()
    }
    

}
