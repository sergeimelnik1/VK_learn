//
//  FriendListRouter.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

class FriendListRouter: FriendListRouterInput {
    func showCurrentFriend(from vc: UIViewController, friend: FriendModel) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CurrentFriendViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
//        viewController.output?.setFriendValue(friend)
        viewController.modalPresentationStyle = .fullScreen
        vc.present(viewController, animated: false, completion: nil)
    }
    
    func showLoadFriendsError(_ error: Error, _ vc: UIViewController) {
        let alert = UIAlertController(title: "ОШИБКА ПОДГРУЗКИ", message: "ВЕРНИСЬ НАЗАД", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
