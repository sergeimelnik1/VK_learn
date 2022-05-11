//
//  FriendListPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit
import RealmSwift

class FriendListPresenter {
    
    var view: FriendListViewInput!
    var interactor: FriendListInteractorInput!
    var router: FriendListRouterInput!
    var friends: Results<Friend>?
}

extension FriendListPresenter: FriendListInteractorOutput {
    func loadFriendsSuccess(_ friends: Results<Friend>) {
        self.friends = friends
//        self.view.reload()
    }
    
    func loadFriendsError(_ error: Error) {
        self.router.showLoadFriendsError(error)
    }
    

}

extension FriendListPresenter: FriendListRouterOutput {
    
}

extension FriendListPresenter: FriendListViewOutput {
    func getCountFriends() -> Int {
        return self.friends?.count ?? 1
    }
    
    func getIndexPathRowFriend(_ row: Int) -> Friend? {
        return self.friends?[row]
    }
    
    func enterFriendCell(friend: Friend) {
        self.router.showCurrentFriend(from: view.getVC(), friend: friend)
    }
    func loadData() {
        interactor.loadData()
    }
    func viewIsReady() {
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
    }
    
    
}
