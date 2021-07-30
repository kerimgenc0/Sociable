//
//  ViewController.swift
//  TrendingRepos
//
//  Created by kerim on 28.07.2021.
//

import Foundation
import UIKit

class TrendingReposViewController: UIViewController  {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var trends: [TrendingRepo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://api.github.com/search/repositories?q=language:swift+sort:stars"
        
        view.addSubview(tableView)
        
        let topConstraint = NSLayoutConstraint.init(
            item: tableView,
            attribute: .topMargin,
            relatedBy: .equal,
            toItem: view,
            attribute: .topMargin,
            multiplier: 1,
            constant: 8
        )
        
        let bottomConstraint = NSLayoutConstraint.init(
            item: tableView,
            attribute: .bottomMargin,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottomMargin,
            multiplier: 1,
            constant: 8
        )
        
        let leadingConstraint = NSLayoutConstraint.init(
            item: tableView,
            attribute: .leadingMargin,
            relatedBy: .equal,
            toItem: view,
            attribute: .leadingMargin,
            multiplier: 1,
            constant: 8
        )
        
        let trailingConstraint = NSLayoutConstraint.init(
            item: tableView,
            attribute: .trailingMargin,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailingMargin,
            multiplier: 1,
            constant: 8
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.indicatorStyle = .black
        tableView.register(TrendingRepoTableViewCell.self, forCellReuseIdentifier: "cell")
        
        getData(from: url)
        
    }
    
    private func getData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) {data, response, error in
            
            guard let data = data, error == nil else{
                print("couldn't get data from url")
                return
            }
            
            var result: Response?
            
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert")
            }
            
            self.trends = result?.items ?? []
       
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        
        task.resume()
        
    }
        
}


extension TrendingReposViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrendingRepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrendingRepoTableViewCell
        cell.prepare(for: trends[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = headerView()
        header.delegate = self
        header.titleLabel.text = "Trending Repos - GitHub"
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = DetailsViewController(trends[indexPath.row])
   //     viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

extension TrendingReposViewController: HeaderViewDelegate {
    func headerViewTapped() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top , animated: true)
    }
}
