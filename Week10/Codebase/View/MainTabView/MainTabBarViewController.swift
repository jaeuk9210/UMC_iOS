//
//  MainTabBarViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit
import Combine

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()

        let feedViewController = FeedViewController()

        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        
        let reelsViewController = ReelsViewController()
        
        self.viewControllers = [feedViewController, reelsViewController ,profileViewController]
        
        tabBar.tintColor = .black

        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let reelsTabBarItem = UITabBarItem(title: "Reels", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        feedViewController.tabBarItem = feedTabBarItem
        reelsViewController.tabBarItem = reelsTabBarItem
        profileViewController.tabBarItem = profileTabBarItem

    }
}
