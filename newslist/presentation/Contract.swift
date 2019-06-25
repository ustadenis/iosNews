//
//  Contract.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

protocol NewsTableView: BaseView {
    func dataDidLoad(data: [News])
}

protocol NewsTablePresenter: BasePresenter {
    func loadData()
}
