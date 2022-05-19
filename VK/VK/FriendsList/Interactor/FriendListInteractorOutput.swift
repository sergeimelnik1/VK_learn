//
//  FriendListInteractorOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import RealmSwift

protocol FriendListInteractorOutput: AnyObject {
    func loadFriendsSuccess(_ friends: Results<FriendModel>)
    func loadFriendsError(_ error: Error)
}
