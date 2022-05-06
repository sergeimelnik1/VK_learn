//
//  AllGroupPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation
import RealmSwift

class AllGroupsPresenter {
    
    var view: AllGroupsViewInput!
    var interactor: AllGroupsInteractorInput!
    var router: AllGroupsRouterInput!
    
    private var groups: Results<Group>?
}

extension AllGroupsPresenter: AllGroupsInteractorOutput {
    func loadGroupsSuccess(_ groups: Results<Group>) {
        self.groups = groups
    }
    
    func loadGroupsError(_ error: Error) {
        self.router.loadGroupsError(error)
    }
    
    
}

extension AllGroupsPresenter: AllGroupsRouterOutput {
    
}

extension AllGroupsPresenter: AllGroupsViewOutput {
    func getIndexPathRowGroup(_ row: Int) -> Group? {
            return self.groups?[row]
    }
    
    func getCountGroups() -> Int {
        return groups?.count ?? 1
    }
    
    func loadGroups() {
        self.interactor.loadGroups()
        
    }
    
    func openOtherGroups() {
        self.router.openOtherGroups(from: view.getVC())
    }
    
    func viewIsReady() {
        
    }
}

