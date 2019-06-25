//
//  File.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

class News {
    
    var imageUrl: String
    var newsTitle: String
    var newsDescription: String
    
    init(imageUrl: String, newsTitle: String, newsDescription: String) {
        self.imageUrl = imageUrl
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
    }
    
}
