//
//  NewsResponse.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

struct NewsResponse {
    let title: String
    let description: String
    let urlToImage: String
}

extension NewsResponse {
    init?(json: Serialization) {
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let urlToImage = json["urlToImage"] as? String
        else {
                return nil
        }
        
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
    }
}
