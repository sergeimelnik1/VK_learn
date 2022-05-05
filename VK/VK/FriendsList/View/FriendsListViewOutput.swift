//
//  FriendsListViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

protocol FriendListViewOutput {
    
    func viewIsReady()
    func enterFriendCell(friend: Friend)
    func loadData()
}
