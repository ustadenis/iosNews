//
//  BasePresenter.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

class BasePresenterImpl<TView: BaseView>: BasePresenter {
    
    var view: TView? = nil
    
    func attach(view: TView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
}
