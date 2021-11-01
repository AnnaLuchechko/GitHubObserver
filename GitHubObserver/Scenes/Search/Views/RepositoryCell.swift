//
//  RepositoryCell.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

extension RepositoryCell {
    func configure(withRepositoryItem item: GitHubRepository) {
        configure(title: item.name)
    }
}
