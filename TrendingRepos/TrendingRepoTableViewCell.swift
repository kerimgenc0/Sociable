//
//  TrendingRepoTableViewCell.swift
//  TrendingRepos
//
//  Created by kerim on 28.07.2021.
//

import Foundation
import UIKit

class TrendingRepoTableViewCell : UITableViewCell {
    
    let profileImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let starLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        [profileImageView,titleLabel,subtitleLabel,starLabel].forEach(contentView.addSubview)
        
        [profileImageView,titleLabel,subtitleLabel,starLabel].forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topConstraint = profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10)
        let leadingConstraint = profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        let widthConstraint = profileImageView.widthAnchor.constraint(equalToConstant: 60)
        let heightConstraint = profileImageView.heightAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([topConstraint,leadingConstraint,widthConstraint,heightConstraint])
        
        let bottomConstraint1 = starLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -10)
        let leadingConstraint1 = starLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        NSLayoutConstraint.activate([bottomConstraint1,leadingConstraint1])
        
        let bottomConstraint2 = subtitleLabel.bottomAnchor.constraint(equalTo: starLabel.topAnchor, constant: 0)
        let leadingConstraint2 = subtitleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        let trailingConstraint2 = subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
        let heightConstraint2 = subtitleLabel.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([bottomConstraint2,leadingConstraint2,trailingConstraint2,heightConstraint2])
        
        let bottomConstraint3 = titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor , constant: 0)
        let leadingConstraint3 = titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        let trailingConstraint3 = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
        NSLayoutConstraint.activate([bottomConstraint3,leadingConstraint3,trailingConstraint3])
        
    }
    
    func prepare(for repo: TrendingRepo){
        
        titleLabel.attributedText = NSAttributedString(string: repo.full_name, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Thonburi", size: 16)!
        ])
   
        subtitleLabel.attributedText = NSAttributedString(string: repo.description ?? "", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: "Thonburi", size: 13)!
        ])
     
        starLabel.attributedText = NSAttributedString(string: "⭐️ \(repo.stargazers_count)", attributes: [
            .foregroundColor: UIColor.orange,
            .font: UIFont(name: "Thonburi", size: 13)!
        ])
 
        DispatchQueue.global().async {
            
            let data = try? Data(contentsOf: URL(string: repo.owner.avatar_url)!)
            
            DispatchQueue.main.async {
                self.profileImageView.contentMode = .scaleAspectFill
                self.profileImageView.image = UIImage(data: data!)
            }
            
        }
 
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol HeaderViewDelegate: NSObjectProtocol {
    func headerViewTapped()
}

class headerView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = UIFont(name: "Thonburi", size: 25)
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: 40)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .red
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        self.addGestureRecognizer(gestureRecognizer)
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(){
        delegate?.headerViewTapped()
    }
    
}
