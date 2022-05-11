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
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
        vc.friend = friend
        vc.modalPresentationStyle = .fullScreen
        vc.present(vc, animated: false, completion: nil)
    }
    
    func showLoadFriendsError(_ error: Error) {
        print(error)
    }
    
    var output: FriendListRouterOutput?
}
