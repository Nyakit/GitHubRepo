//
//  RepoDetailedPresenter.swift
//  GitHubRepo
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import Foundation
import UIKit

protocol RepoDetailedViewPresenterProtocol {
    var view: RepoDetailedViewProtocol? { get set }
    func onShareClick(urlToShare: URL, sender: UIView)
}

class RepoDetailedPresenter : RepoDetailedViewPresenterProtocol {
    weak var view: RepoDetailedViewProtocol?

    func onShareClick(urlToShare: URL, sender: UIView) {
        let objectsToShare = [urlToShare] as [Any]
        let shareVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        shareVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]

        shareVC.popoverPresentationController?.sourceView = sender
        self.view!.showShareDialog(shareVC: shareVC)
    }
}


