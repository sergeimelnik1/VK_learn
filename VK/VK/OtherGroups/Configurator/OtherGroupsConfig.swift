//
//  OtherGroupsConfig.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

class OtherGroupsConfig {

    
    
    var view : OtherGroupsViewInput?
    let presenter = OtherGroupsPresenter()
    
    init(){
        view = OtherGroupsViewController()
        let router = OtherGroupsRouter()
        let interactor = OtherGroupsInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view!.output = presenter
        presenter.view = view
    }
}
