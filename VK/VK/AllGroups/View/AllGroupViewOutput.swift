//
//  AllGroupViewOutput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

protocol AllGroupsViewOutput {
    func viewIsReady()
    func openOtherGroups()
    func loadGroups()
    func getCountGroups() -> Int
    func getIndexPathRowGroup(_ row: Int) -> Group?
    func leaveGroup(_ groupId: Int)
}
