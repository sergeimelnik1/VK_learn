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
        
    }

extension FriendListPresenter: FriendListInteractorOutput {
    func sendFriendDataToView(friend: Results<Friend>) {
        view.loadFriendData(friend: friend)
    }
    

    }

    extension FriendListPresenter: FriendListRouterOutput {
        
    }

extension FriendListPresenter: FriendListViewOutput {
    func enterFriendCell(friend: Friend) {
        self.router.showCurrentFriend(from: view.getVC(), friend: friend)
    }
    func loadData() {
        interactor.loadData()
    }
    func viewIsReady() {
        
    }
    

    }
