//
//  Network.swift
//  GitHubRepo
//
//  Created by Пользователь on 19.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import Alamofire
import Foundation

protocol GetRepoInfoProtocol {
    func getRepoInfo(since: Int, completion: (([Repo]) -> Void)?)
}

open class Network: GetRepoInfoProtocol {
    func getRepoInfo(since: Int, completion: (([Repo]) -> Void)? = nil ) {
        var repos: [Repo] = []

        Alamofire.request("https://api.github.com/repositories?since=\(since)").responseJSON() {
            responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonArray = value as? Array<[String: Any]> else { return }

                for jsonObject in jsonArray {
                    var description = "No description"
                    if let descriptionRepo = jsonObject["description"] as? String {
                        description = descriptionRepo
                    }

                    if let repoId = jsonObject["id"] as? Int,
                        let repoName = jsonObject["name"] as? String,
                        let ownerInfo = jsonObject["owner"] as? [String: Any],
                        let ownerName = ownerInfo["login"] as? String,
                        let descriptionRepo = description as? String,
                        let repoUrl = jsonObject["html_url"] as? String {
                        let repo = Repo(repoId: repoId, repoName: repoName, ownerName: ownerName, descriptionRepo: descriptionRepo, repoUrl: repoUrl)
                        repos.append(repo)
                    } else {
                        break
                    }
                }
                completion?(repos)
            case .failure(let error):
                completion?(repos)
            }
        }
    }
}
