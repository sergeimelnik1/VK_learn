//
//  FriendsListViewInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit
import RealmSwift

protocol FriendListViewInput {
    
    var output: FriendListViewOutput? { get set }
    func getVC() -> UIViewController
    func loadFriendData(friend: Results<Friend>)
}
