//
//  DetailsViewController.swift
//  TrendingRepos
//
//  Created by kerim on 30.07.2021.
//

import Foundation
import UIKit
import SafariServices

class DetailsViewController : UIViewController {
    
    let usernameLabel = UILabel()
    let profileImageView = UIImageView()
    let starsLabel = UILabel()
    let detailsLabel = UILabel()
    let repoButton = UIButton()
    
    var repo: TrendingRepo
    
    
    init(_ repo: TrendingRepo) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        [usernameLabel,profileImageView,starsLabel,detailsLabel,repoButton].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topCon = usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        let leadCon = usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        let traCon = usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        NSLayoutConstraint.activate([topCon,leadCon,traCon])
        
        let topCon2 = profileImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10)
        let widCon2 = profileImageView.widthAnchor.constraint(equalToConstant: 80)
        let heiCon2 = profileImageView.heightAnchor.constraint(equalToConstant: 80)
        let cenCon2 = profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([topCon2,widCon2,cenCon2,heiCon2])
        
        let topCon3 = starsLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
        let leadCon3 = starsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        let traCon3 = starsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        let heiCon3 = starsLabel.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([topCon3,leadCon3,traCon3,heiCon3])
        
        let topCon4 = detailsLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 10)
        let leadCon4 = detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        let traCon4 = detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        NSLayoutConstraint.activate([topCon4,leadCon4,traCon4])
        
        
        let botCon5 = repoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        let cenCon5 = repoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let heiCon5 = repoButton.heightAnchor.constraint(equalToConstant: 25)
        NSLayoutConstraint.activate([botCon5,heiCon5,cenCon5])
        
        detailsLabel.numberOfLines = 0
        usernameLabel.numberOfLines = 0
        
        usernameLabel.font = UIFont(name: "Thonburi", size: 25)
        starsLabel.font = UIFont(name: "Thonburi", size: 20)
        detailsLabel.font = UIFont(name: "Thonburi", size: 16)
        
        usernameLabel.textAlignment = .center
        starsLabel.textAlignment = .center
        
        usernameLabel.text = repo.full_name
        starsLabel.text = "⭐️ \(repo.stargazers_count)"
        detailsLabel.text = repo.description ?? ""
        
        repoButton.setTitle("  View Repo  ", for: UIControl.State.normal)
        repoButton.setTitleColor(.black, for: UIControl.State.normal)
        repoButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 0,bottom: 10,right: 0)
        repoButton.backgroundColor = .systemGreen
        repoButton.addTarget(self, action: #selector(press(_:)), for: .touchUpInside)
        
        DispatchQueue.global().async {
            
            let data = try? Data(contentsOf: URL(string: self.repo.owner.avatar_url)!)
            DispatchQueue.main.async {
                    self.profileImageView.contentMode = .scaleAspectFill
                    self.profileImageView.image = UIImage(data: data!)
            }
            
        }
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.masksToBounds = true
        
    }
    
    @objc func press(_ sender: UIButton){
        if let link = URL(string: repo.html_url) {
            let safarivc = SFSafariViewController(url: link)
            present(safarivc, animated: true, completion: nil)
        }
    }
    
}
