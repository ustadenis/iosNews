//
//  NewsRepository.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

typealias Serialization = [String : Any]

class NewsRepository {
    
    private let newsMapper: NewsMapper = NewsMapper()
    
    func loadNews(withCompletion completion: @escaping ([News]?) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d2cb4413e0024edeabe6c45d7844c291")!
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                    let serializedJson = json as? Serialization,
                    let articles = serializedJson["articles"] as? [Serialization]
                else {
                    completion(nil)
                    return
                }
                var result: [NewsResponse] = []
                articles.forEach({ (article) in
                    if let newsResponse = NewsResponse(json: article) {
                        result.append(newsResponse)
                    }
                })
                completion(self.newsMapper.map(item: result))
            }
        )
        task.resume()
    }
    
}
