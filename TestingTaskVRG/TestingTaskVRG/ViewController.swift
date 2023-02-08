//
//  ViewController.swift
//  TestingTaskVRG
//
//  Created by Evgeniy Lemish on 07.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMostPopular(type: .emailed, period: .period30Days)
        createTable()
    }

    
    var result: [Result] = .init()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func createTable() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = result[indexPath.row]
        cell.textLabel?.text = article.title

        return cell
    }
    
    // MARK: - API
    
    func fetchMostPopular (type: MostPopular, period: Period) {
        APIManager.apiManager.fetchContent(type: type, period: period) { [weak self] (results) in
                self?.result += results
                self?.tableView.reloadData()
        }
    }
}

