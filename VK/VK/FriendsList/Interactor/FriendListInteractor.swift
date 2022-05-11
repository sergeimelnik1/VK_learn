//
//  FriendListInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import RealmSwift

class FriendListInteractor : FriendListInteractorInput {
    func loadData() {
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                FriendService.loadFriendList()
                let friends = realm.objects(Friend.self)
                self.output?.loadFriendsSuccess(friends)
                
            } catch {
                // если произошла ошибка, выводим ее в консоль
                print(error)
            }
    }
    
    
    var output : FriendListInteractorOutput?
    
    
    
}
