//
//  GroupServiceProtocol.swift
//  VK
//
//  Created by Sergey Melnik on 06.05.2022.
//

import Foundation

protocol GroupServiceProtocol: AnyObject {
    func loadGroupList(success: @escaping () -> ())
    func loadSearchGroupList(query: String, success: @escaping ([GroupModel]) -> ())
    func followGroup(groupId: Int, success: @escaping () -> ())
    func leaveGroup(groupId: Int, success: @escaping () -> ())
}
