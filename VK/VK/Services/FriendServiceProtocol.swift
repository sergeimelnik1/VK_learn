//
//  FriendServiceProtocol.swift
//  VK
//
//  Created by Sergey Melnik on 16.05.2022.
//

import Foundation

protocol FriendServiceProtocol: AnyObject {
    static func loadFriendList()
    static func saveFriendsData(_ friends: [FriendModel])
}
