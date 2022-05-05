//
//  TabBarViewController.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation
import UIKit
class TabBarViewController {
    let tabBarVC = UITabBarController()
    let vc1 = UINavigationController(rootViewController: FriendListViewController())
    let vc2 = UINavigationController(rootViewController: AllGroupsViewController())
//    vc1.title = "Мои друзья"
//    vc2.title = "Мои группы"
    
//    tabBarVC.setViewController([vc1, vc2], animated: false)
//    tabBarVC.modalPresentationStyle = .fullScreen
//    present(tabBarVC, animated: true)
}
