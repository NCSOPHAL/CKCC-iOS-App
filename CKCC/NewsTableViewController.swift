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

        articles = loadArticles()
        tableView.reloadData()
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
    
    func loadArticles() -> [Article] {
        
        let request = NSFetchRequest<Article>(entityName: "Article")
        let result = try! AppDelegate.context.fetch(request)
        return result
        
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
