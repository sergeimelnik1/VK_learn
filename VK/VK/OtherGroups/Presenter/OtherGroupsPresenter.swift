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
    var router: OtherGroupsRouterInput!

    
    var groups: [GroupModel] = []
    var currentSearchText = ""
}

extension OtherGroupsPresenter {
    func present(from vc: UIViewController) {
        vc.present(view as! UIViewController, animated: true, completion: nil)
    }
}

extension OtherGroupsPresenter: OtherGroupsInteractorOutput {
    func error(_ error: String) {
        self.groups = []
        self.view.offActivityIndicator()
        self.router.showLoadGroupsError(error, view.getVC())
    }
    
    func success(groups: [GroupModel]) {
        self.view.offActivityIndicator()
        self.groups = groups
        self.view.reload()
    }
}

extension OtherGroupsPresenter: OtherGroupsViewOutput {
    
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
        guard row < groups.count else { return nil }
        return self.groups[row]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.groups = []
        self.view.reload()
        if searchText != "" {
            self.interactor.loadSearchData(searchText)
            self.currentSearchText = searchText
        }
    }
}
