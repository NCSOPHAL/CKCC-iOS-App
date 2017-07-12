//
//  ArticleViewController.swift
//  CKCC
//
//  Created by Bun Leap on 6/19/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ArticleViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var articleImageViewHeightConstraint: NSLayoutConstraint!

    var article: MyArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = article.title
        
        let url = URL(string: article.thumbnailUrl)!
        let imageRequest = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.displayAndResizeArticleImageView(image: image!)
                }
            }
        }
        imageRequest.resume()
        
        contentLabel.text = article.content
    }
    
    func displayAndResizeArticleImageView(image: UIImage) {
        articleImageView.image = image
        let ratio = image.size.width / image.size.height
        let newArticleImageViewHeight = articleImageView.frame.size.width / ratio
        articleImageViewHeightConstraint.constant = newArticleImageViewHeight
    }

    @IBAction func onAddCommentButtonClick(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Comment", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            let comment = alertController.textFields![0].text!
            self.addCommentToFirebase(comment: comment)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func addCommentToFirebase(comment: String) {
        let selectedArticleRef = Database.database().reference(withPath: "articles").child(article.id)
        var commentObj = [String:Any]()
        commentObj["user"] = "ckcc"
        commentObj["comment"] = comment
        commentObj["date"] = CACurrentMediaTime()
        selectedArticleRef.child("comments").childByAutoId().setValue(commentObj) { (error, reference) in
            if(error == nil){
                print("Add comment completed")
            }else{
                print("Add comment error: \(error.debugDescription)")
            }
        }
    }
    
}











