//
//  TabBarViewController.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        var viewControllers: [UIViewController] = []
        let modules: [TabBarViewProtocol] = [AllGroupsConfig(), FriendListConfig()]

        for module in modules {
            viewControllers.append(setupPageController(module))
        }
    
        self.viewControllers = viewControllers
        
        let navigation: UINavigationController = UINavigationController(rootViewController: self)
        navigation.navigationBar.isHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
    }
    
    private func setupPageController(_ module: TabBarViewProtocol) -> UIViewController {
        
        let tabBarItem = UITabBarItem()
        tabBarItem.title = module.title
        tabBarItem.image = module.image
        
        let controller = module.configured()
        controller.tabBarItem = tabBarItem
        controller.title = module.title
        return controller
    }
    
    func getVC() -> UIViewController {
        return self
    }
}
