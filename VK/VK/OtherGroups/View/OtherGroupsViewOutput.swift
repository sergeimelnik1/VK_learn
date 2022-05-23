//
//  OtherGroupsViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

protocol OtherGroupsViewOutput: AnyObject {
    func filterContentForSearchText(_ searchText: String)
    func getCountGroups() -> Int
    func getIndexPathRowGroup(_ row: Int) -> GroupModel?
    func followGroup(_ groupId: Int, _ currentSearchText: String)
    func leaveGroup(_ groupId: Int, _ currentSearchText: String)
    func getGroups() -> [GroupModel]
    func getCurrentSearchText() -> String
    func clearGroup()
}
