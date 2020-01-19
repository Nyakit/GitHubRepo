//
//  RepoListViewController.swift
//  GitHubRepo
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import UIKit
import Foundation

protocol RepoListViewProtocol: class {
    func changeColor(color: UIColor)
    func updateCollection(repos: [Repo])
    func addItemsToCollection(repos: [Repo])
}

class RepoListViewController: UIViewController, RepoListViewProtocol {

    @IBOutlet var collectionView: UICollectionView!

    var repos: [Repo] = []
    var presenter: RepoListViewPresenterProtocol = RepoListPresenter()
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.view = self

        self.collectionViewConfigure()
        self.configurateNavBar()
    }

    private func collectionViewConfigure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "RepoListCell", bundle: nil), forCellWithReuseIdentifier: "RepoListCell")
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.white
        self.refresher.addTarget(self, action: #selector(self.refreshCollection), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configurateNavBar() {
        navigationItem.title = "GitHub Repositories"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
    }

    func changeColor(color: UIColor) {
        self.view.backgroundColor = color
    }

    @objc func refreshCollection(refresher: UIRefreshControl) {
        self.presenter.refreshCollection()
        refresher.endRefreshing()
    }

    private func openRepoDetail(item: Repo) {
        if let nc = self.navigationController {
            self.presenter.onOpenRepoDetailedClick(nc: nc, item: item)
        }
    }

    func updateCollection(repos: [Repo]) {
        self.repos = repos
        self.collectionView.reloadData()
    }

    func addItemsToCollection(repos: [Repo]) {
        self.repos += repos
        self.collectionView.reloadData()
    }
}

extension RepoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openRepoDetail(item: self.repos[indexPath.row])
    }
}

extension RepoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.repos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepoListCell",
                                                      for: indexPath) as! RepoListCell
        cell.config(item: self.repos[indexPath.row])
        return cell
    }
}

extension RepoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 110.0)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.repos.count - 1 ) {
            self.presenter.loadMoreItems(lastItem: self.repos[self.repos.count - 1])
         }
    }
}
