//
//  FriendListRouterInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

protocol FriendListRouterInput {
    func showCurrentFriend(from vc: UIViewController, friend: FriendModel)
    func showLoadFriendsError(_ error: Error, _ vc: UIViewController)
}
