//
//  ArticleViewController.swift
//  CKCC
//
//  Created by Bun Leap on 6/19/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!

    var article: MyArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = article.title
        
        let url = URL(string: article.thumbnailUrl)!
        let imageRequest = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.articleImageView.image = image
            }
        }
        imageRequest.resume()
        
        contentLabel.text = article.content
    }

}
