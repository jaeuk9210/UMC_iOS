//
//  MainTabBarViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit
import Combine

import KakaoSDKUser

class MainTabBarViewController: UITabBarController {

    var userInfo: User?

    override func viewDidLoad() {

        super.viewDidLoad()

        let feedViewController = FeedViewController()

        let profileViewController = UINavigationController(rootViewController: ProfileViewController())

        self.viewControllers = [feedViewController, profileViewController]

        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        feedViewController.tabBarItem = feedTabBarItem
        profileViewController.tabBarItem = profileTabBarItem

    }
}
