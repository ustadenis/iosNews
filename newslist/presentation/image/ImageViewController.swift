//
//  ImageViewController.swift
//  newslist
//
//  Created by Denis Ustavschikov on 25/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageUrl: URL? = nil
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 2.0
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            fetchImage()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageUrl {
            if let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
                imageView.sizeToFit()
            }
        }
    }

}
