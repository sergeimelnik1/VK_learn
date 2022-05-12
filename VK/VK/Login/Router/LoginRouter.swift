//
//  LoginRouter.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import UIKit

class LoginRouter: LoginRouterInput {
    var output: LoginRouterOutput?
    
    func showTabBarController(from vc: UIViewController) {
        let storyboard: UIStoryboard = UIStoryboard(name: "TabBarView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        vc.modalPresentationStyle = .fullScreen
//        vc.present(vc, animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)

    }
}
