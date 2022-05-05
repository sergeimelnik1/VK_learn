//
//  AllGroupConfigurator.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

class AllGroupsConfig {
    
    var view : AllGroupsViewInput?
    let presenter = AllGroupsPresenter()
    
    init(){
        view = AllGroupsViewController()
        let router = AllGroupsRouter()
        let interactor = AllGroupsInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view!.output = presenter
        presenter.view = view
    }
}
