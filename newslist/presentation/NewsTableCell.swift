//
//  NewsTableCell.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import Foundation
import UIKit

class NewsTableCell : UITableViewCell {
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    
    func loadImage(fromUrl url: String) {
        let imageUrl = URL(string: url)!
        
        newsImage.image = UIImage(named: "no-image")
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.newsImage.image = UIImage(data: data)
                }
            }
        }
    }
    
}
