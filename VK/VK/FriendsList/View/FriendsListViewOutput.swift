//
//  FriendsListViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

protocol FriendListViewOutput {
    
    func viewIsReady()
    func enterFriendCell(friend: FriendModel)
    func loadData()
    func getCountFriends() -> Int
    func getIndexPathRowFriend(_ row: Int) -> FriendModel?
}
