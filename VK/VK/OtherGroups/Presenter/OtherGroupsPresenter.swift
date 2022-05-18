//
//  OtherGroupsPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

class OtherGroupsPresenter {
    
    weak var view: OtherGroupsViewInput!
    var interactor: OtherGroupsInteractorInput!
    var groups: [GroupModel] = []
    var currentSearchText = ""
}

extension OtherGroupsPresenter {
    func present(from vc: UIViewController) {
        vc.present(view as! UIViewController, animated: true, completion: nil)
    }
}

extension OtherGroupsPresenter: OtherGroupsInteractorOutput {
    func sendSearchDataToView(_ searchText: String, groups: [GroupModel]) {
        self.groups = groups
        self.currentSearchText = searchText
    }
}

extension OtherGroupsPresenter: OtherGroupsViewOutput {
    func edidCurrentSearchText(_ searchText: String) {
        self.currentSearchText = searchText
    }
    
    func getCurrentSearchText() -> String {
        return currentSearchText
    }
    
    func getGroups() -> [GroupModel] {
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
    
    func getIndexPathRowGroup(_ row: Int) -> GroupModel? {
        if let index: GroupModel? = self.groups[row] {
            return index
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.interactor.loadSearchData(searchText)
    }
}
