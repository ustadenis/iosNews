//
//  NewsTablePresenterImpl.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

class NewsTablePresenterImpl: BasePresenterImpl<NewsTableController>, NewsTablePresenter {
    
    private let newsInteractor: NewsInteractor
    
    init(newsInteractor: NewsInteractor) {
        self.newsInteractor = newsInteractor
    }
    
    func loadData() {
        newsInteractor.loadNews { (news) in
            if let unwrappedNews = news {
                self.view?.dataDidLoad(data: unwrappedNews)
            }
        }
    }
}
