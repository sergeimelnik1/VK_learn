//
//  LoginPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation
import UIKit
import WebKit

class LoginPresenter {
    
    var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    init(vc: LoginFormController){
        self.view = vc
        let router = LoginRouter()
        let interactor = LoginInteractor()
        
        interactor.output = self
        self.interactor = interactor
        
        router.output = self
        self.router = router
        }
}
extension LoginPresenter: LoginInteractorOutput {
    func loginSuccess() {
        router.showTabBarController(from: view.getVC())
    }
    
}

extension LoginPresenter: LoginRouterOutput {
    
}

extension LoginPresenter: LoginViewOutput {
    func authVK(decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        self.interactor.authVK(decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)

    }    
}
