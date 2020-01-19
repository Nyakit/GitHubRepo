//
//  RepoListCell.swift
//  GitHubRepo
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import UIKit

class RepoListCell: UICollectionViewCell {
    @IBOutlet weak var repoIdLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var idWrapperView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.idWrapperView.layer.cornerRadius = self.idWrapperView.frame.height / 2


        if #available(iOS 11.0, *) {
            self.idWrapperView.layer.maskedCorners = [.layerMinXMaxYCorner]
        }
    }

    func config(item: Repo) {
        self.repoIdLabel.text = "\(item.repoId)" 
        self.repoNameLabel.text = item.repoName
        self.ownerNameLabel.text = item.ownerName
        self.descriptionLabel.text = item.descriptionRepo
    }
}
