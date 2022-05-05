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
        let storyboard: UIStoryboard = UIStoryboard(name: "CurrentFriendViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
        vc.modalPresentationStyle = .fullScreen
        vc.present(vc, animated: false, completion: nil)
    }
}
