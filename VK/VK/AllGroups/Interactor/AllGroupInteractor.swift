//
//  AllGroupInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation
import RealmSwift

class AllGroupsInteractor : AllGroupsInteractorInput {
    
    var output : AllGroupsInteractorOutput?
    
    func loadGroups() {
        do {
            let realm = try Realm()
            GroupService.loadGroupList(success: { [weak self] in
                let groups = realm.objects(Group.self)
                self?.output?.loadGroupsSuccess(groups)
            })
        } catch {
            // если произошла ошибка, выводим ее в консоль
            output?.loadGroupsError(error)
        }
    }
}
