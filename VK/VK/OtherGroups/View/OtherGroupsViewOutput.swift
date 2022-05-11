//
//  OtherGroupsViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

protocol OtherGroupsViewOutput {
    func viewIsReady()
    func filterContentForSearchText(_ searchText: String)
    func getCountGroups() -> Int
    func getIndexPathRowGroup(_ row: Int) -> Group?
    func followGroup(_ groupId: Int, _ currentSearchText: String)
    func leaveGroup(_ groupId: Int, _ currentSearchText: String)
    func getGroups() -> [Group]
}
