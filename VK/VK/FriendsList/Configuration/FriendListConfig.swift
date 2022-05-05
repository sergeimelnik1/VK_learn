//
//  FriendListConfig.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

class FriendListConfig {
    
    var view : FriendListViewInput
    let presenter = FriendListPresenter()
    
    init(){
        view = FriendListViewController()
        let router = FriendListRouter()
        let interactor = FriendListInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view.output = presenter
        presenter.view = view
    }
}
