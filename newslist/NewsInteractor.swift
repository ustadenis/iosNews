//
//  NewsInteractor.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

class NewsInteractor {
    
    private let newsRepository: NewsRepository
    
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func loadNews(withCompletion completion: @escaping ([News]?) -> Void) {
        newsRepository.loadNews(withCompletion: completion)
    }
    
}
