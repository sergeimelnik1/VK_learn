//
//  GroupServiceProtocol.swift
//  VK
//
//  Created by Sergey Melnik on 06.05.2022.
//

import Foundation

protocol GroupServiceProtocol: AnyObject {
    func loadGroupList(success: @escaping () -> (), fail: @escaping (Error) -> ())
    func loadSearchGroupList(query: String, success: @escaping ([GroupModel]) -> (), fail: @escaping (Error) -> ())
    func followGroup(groupId: Int, success: @escaping () -> (), fail: @escaping (Error) -> ())
    func leaveGroup(groupId: Int, success: @escaping () -> (), fail: @escaping (Error) -> ())
}
