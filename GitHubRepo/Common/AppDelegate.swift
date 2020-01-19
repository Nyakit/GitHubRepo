//
//  AppDelegate.swift
//  dafsgrhtjghj
//
//  Created by Пользователь on 18.01.2020.
//  Copyright © 2020 Darina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let vc = RepoListViewController()
        let nc = UINavigationController(rootViewController: vc)
        self.window!.rootViewController = nc
        self.window!.backgroundColor = .white
        self.window!.makeKeyAndVisible()
        return true
    }
}

