//
//  FriendListPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit
import RealmSwift

class FriendListPresenter {
    
    weak var view: FriendListViewInput!
    var interactor: FriendListInteractorInput!
    var router: FriendListRouterInput!
    
    private var friends: Results<FriendModel>?
}

extension FriendListPresenter: FriendListInteractorOutput {
    func loadFriendsSuccess(_ friends: Results<FriendModel>) {
        self.view.offActivityIndicator()
        self.friends = friends
        self.view.reload()
    }
    
    func loadFriendsError(_ error: Error) {
        self.view.offActivityIndicator()
        self.router.showLoadFriendsError(error, view.getVC())
    }
}

extension FriendListPresenter: FriendListViewOutput {
    func getCountFriends() -> Int {
        return self.friends?.count ?? 1
    }
    
    func getIndexPathRowFriend(_ row: Int) -> FriendModel? {
        guard let friends = self.friends, row < friends.count else { return nil }
            return friends[row]
    }
    
    func enterFriendCell(friend: FriendModel) {
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
        
        self.loadData()
    }
}
