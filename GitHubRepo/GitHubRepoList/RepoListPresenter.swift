//
//  RepoDetailedPresenter.swift
//  GitHubRepo
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import Foundation
import UIKit

protocol RepoListViewPresenterProtocol {
    var view: RepoListViewProtocol? { get set }
    func refreshCollection()
    func loadMoreItems(lastItem: Repo)
    func onOpenRepoDetailedClick(nc: UINavigationController, item: Repo)
}

class RepoListPresenter : RepoListViewPresenterProtocol {
    weak var view: RepoListViewProtocol?
    var network: GetRepoInfoProtocol = Network()

    init() {
        self.network.getRepoInfo(since: 0) { [weak self] repos in
            self?.updateCollection(repos: repos)
        }
    }

    func refreshCollection() {
        self.network.getRepoInfo(since: 0) { [weak self] repos in
            self?.updateCollection(repos: repos)
        }
    }

    internal func loadMoreItems(lastItem: Repo) {
        self.network.getRepoInfo(since: lastItem.repoId) { [weak self] repos in
            self?.addItemsToCollection(repos: repos)
        }
    }

    func onOpenRepoDetailedClick(nc: UINavigationController, item: Repo) {
        let vc = RepoDetailedViewController()
        vc.item = item
        nc.pushViewController(vc, animated: true)
    }

    private func updateCollection(repos: [Repo]) {
        self.view?.updateCollection(repos: repos)
    }

    private func addItemsToCollection(repos: [Repo]) {
        self.view?.addItemsToCollection(repos: repos)
    }
}
