//
//  AboutViewController.swift
//  CKCC
//
//  Created by Bun Leap on 6/28/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AboutViewController: UITableViewController {

    @IBAction func onCheckPermissionClick(_ sender: Any) {
        let token = FBSDKAccessToken.current()
        let permissions = token?.permissions
        print(permissions)
    }
    @IBAction func onRequestAdditionalPermissionClick(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withPublishPermissions: ["publish_actions"], from: self) { (result, error) in
            if let errorObject = error {
                print("Additional permissions error: \(errorObject)")
            }else{
                print("Additional permissions success")
            }
        }
    }
    @IBAction func onPostToFacebookButtonClick(_ sender: Any) {
        
        let content = "Download CKCC App on the App Store: http://rupp.edu.kh/ckcc"
        let request = FBSDKGraphRequest.init(graphPath: "/feed", parameters: ["message":content], httpMethod: "POST")!
        request.start { (connection, data, error) in
            if let errorObject = error {
                print(errorObject)
            }else{
                print("Post status success")
            }
        }
        
    }
    

}
