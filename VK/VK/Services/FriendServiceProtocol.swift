//
//  FriendServiceProtocol.swift
//  VK
//
//  Created by Sergey Melnik on 16.05.2022.
//

import Foundation

protocol FriendServiceProtocol: AnyObject {
    func loadFriendList(success: @escaping () -> (), fail: @escaping (Error) -> ())
    func saveFriendsData(_ friends: [FriendModel])
}
