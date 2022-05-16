//
//  CurrentFriendPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import Foundation

class CurrentFriendPresenter {
    
    var view: CurrentFriendViewInput!
    var interactor: CurrentFriendInteractorInput!
    var router: CurrentFriendRouterInput!
    
}

extension CurrentFriendPresenter: CurrentFriendInteractorOutput {
    
}

extension CurrentFriendPresenter: CurrentFriendRouterOutput {
    
}

extension CurrentFriendPresenter: CurrentFriendViewOutput {
    func viewIsReady() {
        
    }
}

