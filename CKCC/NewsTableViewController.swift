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

    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadArticlesFromServer()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_article") as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.dateLabel.text = article.date?.description
        return cell
    }
    
    func loadArticlesFromDb() -> [Article] {
        
        let request = NSFetchRequest<Article>(entityName: "Article")
        let result = try! AppDelegate.context.fetch(request)
        return result
        
    }
    
    func loadArticlesFromServer() {
        let serverAddress = "http://localhost/test/ckcc-api/news.php"
        let url = URL(string: serverAddress)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let str = String(data: data!, encoding: .utf8)!
            print(str)
            let array = try! JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
            var articles = [Article]()
            for item in array {
                let articleItem = item as! [String:Any]
                let id = articleItem["id"] as! Int
                let title = articleItem["title"] as! String
                let content = articleItem["content"] as! String
                let thumbnail = articleItem["thumbnail_url"] as! String
                
                //let article = Article(id: id, title: title, content: content, date: Date(), thumbnailUrl: thumbnail)
                let article = Article()
                
                articles.append(article)
            }
            self.articles = articles
            self.tableView.reloadData()
        }
        task.resume()
    }
    
    // Temporarily insert articles
    func insertPreArticles(){
        let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: AppDelegate.context) as! Article
        article.title = "Korean Shows"
        article.date = NSDate()
        article.imageUrl = "http://rupp.edu.kh/ckcc/images/b.jpg"
        try! AppDelegate.context.save()
    }

}
