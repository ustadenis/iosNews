//
//  BaseContract.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

protocol BaseView {
    associatedtype TPresenter
    
    var presenter: TPresenter { get }
}

protocol BasePresenter {
    associatedtype TView
    
    func attach(view: TView)
    func detachView()
}
