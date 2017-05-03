//
//  NewsTableViewController.swift
//  CKCC
//
//  Created by Bun Leap on 4/26/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

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
        cell.dateLabel.text = article.date
        return cell
    }
    
    func loadArticles() -> [Article] {
        
        let a1 = Article(title: "CKCC Winter Exhibition", date: "25 April 2017", imageUrl: "")
        let a2 = Article(title: "Korean Seminar", date: "23 April 2017", imageUrl: "")
        let a3 = Article(title: "Karate Show", date: "20 April 2017", imageUrl: "")
        let articles = [a1, a2, a3]
        return articles
        
    }

}
