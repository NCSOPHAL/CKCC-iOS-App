//
//  ChangeProfileImageViewController.swift
//  CKCC
//
//  Created by Bun Leap on 7/12/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ChangeProfileImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var activityInidicator: UIActivityIndicatorView!
    
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply tap gesture to profile imageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onProfileImageViewClick))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // Load profile image from Firebase storage
        loadProfileImageFromFirebaseStorage()
    }
    
    //MARK: - Selector
    func onProfileImageViewClick() {
        print("onProfileImageViewClick")
        // Open gallery to select a picture
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }

    @IBAction func onSaveButtonClick(_ sender: Any) {
        // Upload selected image to Firebase storage
        if selectedImage == nil {
            let alertController = UIAlertController(title: "Profile Image", message: "Please select a picture to change.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }else{
            let profilesRef = Storage.storage().reference(withPath: "profiles")
            let profileImageName = Auth.auth().currentUser!.uid + ".png"
            let profileRef = profilesRef.child(profileImageName)
            let profileImageData = UIImagePNGRepresentation(selectedImage!)!
            activityInidicator.isHidden = false
            profileRef.putData(profileImageData, metadata: nil, completion: { (metaData, error) in
                DispatchQueue.main.async {
                    self.activityInidicator.isHidden = true
                    if error == nil {
                        let alertController = UIAlertController(title: "Profile Image", message: "Change profile success.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "Profile Image", message: "Change profile fail.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        print("Save profile error: \(error.debugDescription)")
                    }
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileImageView.image = selectedImage
    }
    
    func loadProfileImageFromFirebaseStorage() {
        let profilesRef = Storage.storage().reference(withPath: "profiles")
        let profileImageName = Auth.auth().currentUser!.uid + ".png"
        let profileRef = profilesRef.child(profileImageName)
        activityInidicator.isHidden = false
        profileRef.getData(maxSize: 10240000) { (data, error) in
            DispatchQueue.main.async {
                self.activityInidicator.isHidden = true
                if error == nil {
                    let profileImage = UIImage(data: data!)
                    self.profileImageView.image = profileImage
                }else{
                    print("Load profile image error: ", error.debugDescription)
                }
            }
        }
    }

}
























