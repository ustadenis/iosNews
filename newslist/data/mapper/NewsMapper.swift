//
//  NewsMapper.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

class NewsMapper: Mapper {
    
    func map(item: [NewsResponse]) -> [News] {
        var result: [News] = []
        item.forEach { (response) in
            result.append(News(imageUrl: response.urlToImage, newsTitle: response.title, newsDescription: response.description ))
        }
        return result
    }
    
}
