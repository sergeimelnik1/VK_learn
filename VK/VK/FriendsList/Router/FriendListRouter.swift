//
//  FriendListRouter.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

class FriendListRouter: FriendListRouterInput {
    func showCurrentFriend(from vc: UIViewController, friend: Friend) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CurrentFriendViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
        viewController.friend = friend
        viewController.modalPresentationStyle = .fullScreen
        vc.present(viewController, animated: false, completion: nil)
    }
    
    func showLoadFriendsError(_ error: Error) {
        print(error)
    }
    
    var output: FriendListRouterOutput?
}
