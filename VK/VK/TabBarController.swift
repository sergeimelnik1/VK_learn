//
//  TabBarController.swift
//  VK
//
//  Created by Sergey Melnik on 15.04.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        let firstViewController = AllGroupsViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let secondViewController = FriendsViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
