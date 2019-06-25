//
//  DetailsControllerViewController.swift
//  newslist
//
//  Created by Denis Ustavschikov on 24/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var data: News?
    
    
    
    @IBOutlet weak var image: UIImageView! {
        didSet {
            if let url = data?.imageUrl {
                let imageUrl = URL(string: url)!
                
                image.image = UIImage(named: "no-image")
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.image.image = UIImage(data: data)
                        }
                    }
                }
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.imageTap))
            image.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func imageTap() {
        performSegue(withIdentifier: "imageSegue", sender: self)
    }
    
    @IBOutlet weak var newsTitle: UILabel! {
        didSet {
            newsTitle.text = data?.newsTitle
        }
    }
    @IBOutlet weak var newsDescription: UILabel! {
        didSet {
            newsDescription.text = data?.newsDescription
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageSegue" {
            if let imageConstroller = segue.destination as? ImageViewController,
                let data = self.data{
                imageConstroller.imageUrl = URL(string: data.imageUrl)
            }
        }
    }
}
