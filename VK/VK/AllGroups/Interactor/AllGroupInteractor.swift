//
//  AllGroupInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation
import RealmSwift

final class AllGroupsInteractor : AllGroupsInteractorInput {
    
    var output : AllGroupsInteractorOutput?
    var groupService: GroupServiceProtocol!
    
    func leaveGroup(_ groupId: Int) {
        groupService.leaveGroup(groupId: groupId, success: { [weak self] in
            self?.loadGroups()
        })
    }
    
    func loadGroups() {
        do {
            let realm = try Realm()
            
            groupService.loadGroupList(success: { [weak self] in
                let groups = realm.objects(GroupModel.self)
                self?.output?.loadGroupsSuccess(groups)
            })
        } catch {
            output?.loadGroupsError(error)
        }
    }
}
