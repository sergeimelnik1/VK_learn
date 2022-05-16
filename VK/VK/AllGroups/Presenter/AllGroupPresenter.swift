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
    var bar: Bar!
    
    private var groups: Results<Group>?
}

extension AllGroupsPresenter: AllGroupsInteractorOutput {
    func loadGroupsSuccess(_ groups: Results<Group>) {
        self.groups = groups
        self.view.reload()
    }
    
    func loadGroupsError(_ error: Error) {
        self.router.showLoadGroupsError(error)
    }
}

extension AllGroupsPresenter: AllGroupsRouterOutput {
    
}

extension AllGroupsPresenter: AllGroupsViewOutput {
    func leaveGroup(_ groupId: Int) {
        self.interactor.leaveGroup(groupId)
    }
    
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
        self.router.openOtherGroups(self.view.getVC())
    }
    
    func viewIsReady() {
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadGroupsAfterEdit), name: NSNotification.Name(rawValue: "LoadGroups"), object: nil)
        self.interactor.loadGroups()

    }
    //метод дергается после нотификации о удалении или добавлении группы
    @objc func loadGroupsAfterEdit(notification: Notification) {
        self.interactor.loadGroups()
        self.view.reload()
    }
}

