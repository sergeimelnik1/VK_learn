//
//  FriendListInteractorOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import RealmSwift

protocol FriendListInteractorOutput {
    func sendFriendDataToView(friend: Results<Friend>)
}
