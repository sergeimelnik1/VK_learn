//
//  FriendListRouterInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

protocol FriendListRouterInput {
    
    var output: FriendListRouterOutput? { get set }
    func showCurrentFriend(from vc: UIViewController, friend: Friend)
    func showLoadFriendsError(_ error: Error)
}
