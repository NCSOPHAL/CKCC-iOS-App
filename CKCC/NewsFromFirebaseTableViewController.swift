//
//  NewsFromFirebaseTableViewController.swift
//  CKCC
//
//  Created by Bun Leap on 7/10/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsFromFirebaseTableViewController: UITableViewController {

    var articles = [MyArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register ArticleViewCell.xib to TableView
        let nib = UINib(nibName: "ArticleViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "article_view_cell")
        
        // Request articles from Firebase
        let rootRef = Database.database().reference()
        let articlesRef = rootRef.child("articles")
        articlesRef.queryOrdered(byChild: "title").observe(.value, with: { (dataSnapshot) in
            print("Data changed")
            var articlesFromFirebase = [MyArticle]()
            for subSnapshot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                let articleItem = subSnapshot.value as! [String:Any]
                let id = subSnapshot.key
                let title = articleItem["title"] as! String
                let date = 0
                let content = articleItem["content"] as! String
                let thumbnailUrl = articleItem["thumbnailUrl"] as! String
                
                let articleObject = MyArticle(id: id, title: title, content: content, date: date, thumbnailUrl: thumbnailUrl)
                articlesFromFirebase.append(articleObject)
            }
            self.articles = articlesFromFirebase
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_view_cell") as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        
        let url = URL(string: article.thumbnailUrl)!
        let imageRequest = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        imageRequest.resume()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "segue_article", sender: selectedCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get selected article
        let selectedCell = sender as! ArticleTableViewCell
        let indexPath = tableView.indexPath(for: selectedCell)!
        let selectedArticle = articles[indexPath.row]
        
        let articleViewController = segue.destination as! ArticleViewController
        articleViewController.article = selectedArticle
    }

}
