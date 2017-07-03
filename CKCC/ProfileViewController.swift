//
//  ProfileViewController.swift
//  CKCC
//
//  Created by Bun Leap on 24/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

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
        
        /*
        // Load profile from server
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
            
            DispatchQueue.main.async {
                self.nameLabel.text = name
                self.genderLabel.text = gender
                self.phoneLabel.text = phone
                self.emailLabel.text = email
                self.placeOfBirthLabel.text = pob
                self.profileLoadingIndicator.isHidden = true
            }
            
            self.showImageFromServer(imageUrl: imageUrl)
        }
        requestTask.resume()
        */
        
        // Load profile from Facebook
        let request = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields":"id,name,email,birthday,gender,hometown"], httpMethod: "GET")!
        request.start(completionHandler: { (connection, result, error) in
            print(result!)
            let data = result as! [String:Any]
            let name = data["name"] as! String
            let gender = data["gender"] as! String
            let email = data["email"] as! String
            DispatchQueue.main.async {
                self.nameLabel.text = name
                self.genderLabel.text = gender
                self.emailLabel.text = email
            }
        })
        
        // Load profile image
        let profileImageSize = CGSize(width: 200, height: 200)
        let profileImageUrl = FBSDKProfile.current().imageURL(for: .square, size: profileImageSize)!
        let imageRequest = URLSession.shared.dataTask(with: profileImageUrl) { (data, response, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
        imageRequest.resume()
        
    }
    
    func showImageFromServer(imageUrl: String) {
        let url = URL(string: imageUrl)!
        let imageTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
        imageTask.resume()
    }
    

}
