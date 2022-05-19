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
        #warning("Сделать проверку на индекс")
        return self.friends?[row]
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
    
        self.view.onActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadData()
        }
        self.view.offActivityIndicator()
    }
}
