//
//  CurrentFriendConfig.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import Foundation

class CurrentFriendConfig {
    
    var view : CurrentFriendViewInput?
    let presenter = CurrentFriendPresenter()
    
    init(){
        view = CurrentFriendViewController()
        let router = CurrentFriendRouter()
        let interactor = CurrentFriendInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view!.output = presenter
        presenter.view = view
    }
}
