//
//  LoginConfig.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation

class LoginConfig {
    
    var view : LoginFormInput?
    let presenter = LoginPresenter()
    
    init(){
        view = LoginFormController()
        let router = LoginRouter()
        let interactor = LoginInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view!.output = presenter
        presenter.view = view
    }
}
