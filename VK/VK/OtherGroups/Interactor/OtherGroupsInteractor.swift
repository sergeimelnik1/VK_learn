//
//  OtherGroupsInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

class OtherGroupsInteractor : OtherGroupsInteractorInput {
    func leaveGroup(_ groupId: Int, _ currentSearchText: String) {
        GroupService().leaveGroup(groupId: groupId, success: { [weak self] in
            self?.loadSearchData(currentSearchText)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        })
    }
    
    func followGroup(_ groupId: Int, _ currentSearchText: String) {
        GroupService().followGroup(groupId: groupId, success: { [weak self] in
            self?.loadSearchData(currentSearchText)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        })
    }
    
    func loadSearchData(_ searchText: String) {
        if searchText != "" {
            GroupService().loadSearchGroupList(query: searchText, success: { [weak self] groups in
                self?.output?.sendSearchDataToView(searchText, groups: groups)
            })
        } else {
            self.output?.sendSearchDataToView(searchText, groups: [])
        }
    }
    
    var output : OtherGroupsInteractorOutput?
}
