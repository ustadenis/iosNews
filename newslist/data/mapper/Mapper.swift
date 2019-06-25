//
//  Mapper.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype Target
    associatedtype Source
    
    func map(item: Source) -> Target
}
