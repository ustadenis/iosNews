//
//  NewsRepository.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import CoreData

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
                    completion(self.getNewsFromDb())
                    return
                }
                var result: [NewsResponse] = []
                articles.forEach({ (article) in
                    if let newsResponse = NewsResponse(json: article) {
                        result.append(newsResponse)
                    }
                })
                let news = self.newsMapper.map(item: result)
                self.saveInDB(news: news)
                completion(news)
            }
        )
        task.resume()
    }
    
    private func saveInDB(news: [News]) {
        guard let context = AppDelegate.managedContext else {
            return
        }
        cleareNewsDB()
        news.forEach { (news) in
            let newsModel = NewsModel(context: context)
            newsModel.title = news.newsTitle
            newsModel.newsDescription = news.newsDescription
            newsModel.imageUrl = URL(string: news.imageUrl)
        }
        try? context.save()
    }
    
    private func getNewsFromDb() -> [News]? {
        guard let context = AppDelegate.managedContext else {
            return nil
        }
        var newsResult: [News] = []
        let request: NSFetchRequest<NewsModel> = NewsModel.fetchRequest()
        if let result = try? context.fetch(request) {
            result.forEach { (news) in
                newsResult.append(News(imageUrl: news.imageUrl?.absoluteString ?? "", newsTitle: news.title ?? "", newsDescription: news.newsDescription ?? ""))
            }
        }
        return newsResult
    }
    
    private func cleareNewsDB() {
        guard let context = AppDelegate.managedContext else {
            return
        }
        let request: NSFetchRequest<NewsModel> = NewsModel.fetchRequest()
        if let result = try? context.fetch(request) {
            result.forEach { (news) in
                context.delete(news)
            }
        }
    }
    
}
