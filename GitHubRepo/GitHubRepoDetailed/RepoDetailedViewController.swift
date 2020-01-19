//
//  RepoDetailedViewController.swift
//  GitHubRepo
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import UIKit
import Foundation

protocol RepoDetailedViewProtocol: class {
    func showShareDialog(shareVC: UIViewController)
}

class RepoDetailedViewController: UIViewController, RepoDetailedViewProtocol {
    @IBOutlet weak var webView: UIWebView!

    private var presenter: RepoDetailedViewPresenterProtocol = RepoDetailedPresenter()
    public var item: Repo = Repo()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.view = self
        self.configurateNavBar()
        webViewConfigure()
    }

    func configurateNavBar() {
        navigationItem.title = item.ownerName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
}

    private func webViewConfigure() {
        let url = URL(string: item.repoUrl);
        let request = URLRequest(url: url!);
        self.webView.loadRequest(request)
    }

    @objc func share(sender: UIView) {
        if let websiteUrl = URL(string: item.repoUrl) {
            self.presenter.onShareClick(urlToShare: websiteUrl, sender: sender)
        }
    }

    func showShareDialog(shareVC: UIViewController) {
        present(shareVC, animated: true, completion: nil)
    }
}
