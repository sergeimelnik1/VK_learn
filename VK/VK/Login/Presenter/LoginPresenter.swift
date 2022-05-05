//
//  LoginPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation

class LoginPresenter {
    
        var view: LoginFormInput!
        var interactor: LoginInteractorInput!
        var router: LoginRouterInput!
        
    }

    extension LoginPresenter: LoginInteractorOutput {
        
    }

    extension LoginPresenter: LoginRouterOutput {
        
    }

extension LoginPresenter: LoginFormOutput {
    func loginSuccess() {
        self.router.showTabBarController(from: view.getVC())
    }
    
    

    }
