//
//  FriendListInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import RealmSwift

final class FriendListInteractor : FriendListInteractorInput {
    
    var friendService: FriendServiceProtocol!

    func loadData() {
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                friendService.loadFriendList(success: { [weak self] in
                    let friends = realm.objects(FriendModel.self)
                    self?.output?.loadFriendsSuccess(friends)
                }, fail: { [weak self] error in
                    self?.output?.loadFriendsError(error)
                })
            } catch {
                // если произошла ошибка, выводим ее в консоль
                self.output?.loadFriendsError(error)
            }
    }
    
    var output : FriendListInteractorOutput?
}
