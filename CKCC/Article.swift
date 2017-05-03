//
//  Article.swift
//  CKCC
//
//  Created by Bun Leap on 29/3/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import Foundation

class Article {
    
    var title : String!
    var date : String!
    var imageUrl : String!
    
    init(title: String, date: String, imageUrl: String) {
        self.title = title
        self.date = date
        self.imageUrl = imageUrl
    }
    
}
