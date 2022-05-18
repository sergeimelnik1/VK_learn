//
//  CurrentFriendViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import Foundation

protocol CurrentFriendViewOutput {
    func viewIsReady()
    func setFriendValue(_ friend: FriendModel)
    func getFriendValue() -> FriendModel?
}
