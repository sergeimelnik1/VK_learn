//
//  OtherGroupsInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

final class OtherGroupsInteractor : OtherGroupsInteractorInput {
    
    var groupService: GroupServiceProtocol!
    
    func leaveGroup(_ groupId: Int, _ currentSearchText: String) {
        groupService.leaveGroup(groupId: groupId, success: { [weak self] in
            self?.loadSearchData(currentSearchText)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        }, fail: { [weak self] error in
            self?.output?.error(error)
        })
    }
    
    func followGroup(_ groupId: Int, _ currentSearchText: String) {
        groupService.followGroup(groupId: groupId, success: { [weak self] in
            self?.loadSearchData(currentSearchText)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        }, fail: { [weak self] error in
            self?.output?.error(error)
        })
    }
    
    func loadSearchData(_ searchText: String) {
        if searchText != "" {
            groupService.loadSearchGroupList(query: searchText, success: { [weak self] groups in
                self?.output?.success(groups: groups)
            }, fail: { [weak self] error in
                self?.output?.error(error)
            })
        }
    }
    
    var output : OtherGroupsInteractorOutput?
}
