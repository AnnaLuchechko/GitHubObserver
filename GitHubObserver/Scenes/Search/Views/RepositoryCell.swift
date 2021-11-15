//
//  RepositoryCell.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var starsCount: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    func configure(item: GitHubRepository) {
        titleLabel.text = item.fullName
        starsCount.text = "\(item.stargazersCount)"
    }
}

extension RepositoryCell {
    func configure(withRepositoryItem item: GitHubRepository) {
        configure(item: item)
    }
}
