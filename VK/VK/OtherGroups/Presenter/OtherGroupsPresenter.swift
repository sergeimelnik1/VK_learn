//
//  OtherGroupsPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

class OtherGroupsPresenter {
    
        weak var view: OtherGroupsViewInput!
        var interactor: OtherGroupsInteractorInput!
        var router: OtherGroupsRouterInput!
        var groups: [Group] = []
    }

extension OtherGroupsPresenter: OtherGroupsInteractorOutput {
    func sendSearchDataToView(_ searchText: String, groups: [Group]) {
        self.groups = groups
//        view.loadSearchData(searchText, groups: groups)
    }
    
        
    }

    extension OtherGroupsPresenter: OtherGroupsRouterOutput {
        
    }

extension OtherGroupsPresenter: OtherGroupsViewOutput {
    func getGroups() -> [Group] {
        return groups
    }
    
    func leaveGroup(_ groupId: Int, _ currentSearchText: String) {
        self.interactor.leaveGroup(groupId, currentSearchText)
    }
    
    func followGroup(_ groupId: Int, _ currentSearchText: String) {
        self.interactor.followGroup(groupId, currentSearchText)
    }
    
    func getCountGroups() -> Int {
        return groups.count
    }
    
    func getIndexPathRowGroup(_ row: Int) -> Group? {
        return self.groups[row]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.interactor.loadSearchData(searchText)
    }
    
    func viewIsReady() {
    
    }
    

    }

