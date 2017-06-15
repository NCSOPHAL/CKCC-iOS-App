//
//  NewsTableViewController.swift
//  CKCC
//
//  Created by Bun Leap on 4/26/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import CoreData

class NewsTableViewController: UITableViewController {

    var articles = [MyArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request articles from server
        let url = URL(string: "http://test.js-cambodia.com/ckcc/news.json")!
        //let url = URL(string: "http://localhost/test/ckcc-api/news.php")!
        let articlesRequest = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let items = try! JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
            for item in items {
                let articleItem = item as! [String:Any]
                let id = articleItem["id"] as! Int
                let title = articleItem["title"] as! String
                let date = articleItem["date"] as! Int
                let content = articleItem["content"] as! String
                let thumbnailUrl = articleItem["thumbnail_url"] as! String
                
                let articleObject = MyArticle(id: id, title: title, content: content, date: date, thumbnailUrl: thumbnailUrl)
                self.articles.append(articleObject)
            }
            self.tableView.reloadData()
        }
        articlesRequest.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_article") as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.dateLabel.text = ""
        
        let url = URL(string: article.thumbnailUrl)!
        let imageRequest = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let image = UIImage(data: data!)
            cell.thumbnailImageView.image = image
        }
        imageRequest.resume()
        
        return cell
    }

}
