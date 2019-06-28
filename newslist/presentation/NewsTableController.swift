//
//  NewsTableController.swift
//  newslist
//
//  Created by Denis Ustavschikov on 21/06/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit

class NewsTableController: UITableViewController, NewsTableView {
    
    typealias TPresenter = NewsTablePresenterImpl
    
    var presenter: NewsTablePresenterImpl = NewsTablePresenterImpl(newsInteractor: NewsInteractor(newsRepository: NewsRepository()))
    
    private var data: [News] = []
    
    private var selectedData: News? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attach(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.detachView()
    }
    
    func dataDidLoad(data: [News]) {
        self.data = data
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as? NewsTableCell else {
            fatalError()
        }
        
        let url = URL(string: data[indexPath.row].imageUrl)
        
        cell.newsLabel.text = data[indexPath.row].newsTitle
        cell.url = url
        cell.newsDescription.text = data[indexPath.row].newsDescription
        
        cell.newsImage.image = UIImage(named: "no-image")
        
        if let unwrappedUrl = url {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: unwrappedUrl) {
                    DispatchQueue.main.async {
                        if cell.url == unwrappedUrl {
                            cell.newsImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedData = self.data[indexPath.row]
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "detailsSegue") {
            if let dest = segue.destination as? DetailsViewController {
                dest.data = selectedData
            }
        }
    }

}
