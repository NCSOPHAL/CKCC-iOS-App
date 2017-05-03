//
//  ContactViewController.swift
//  CKCC
//
//  Created by Bun Leap on 27/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    
    @IBAction func onMapButtonClick(_ sender: Any) {
        
        performSegue(withIdentifier: "segue_map", sender: nil)
        
    }


}
