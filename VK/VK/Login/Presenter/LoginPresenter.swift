//
//  LoginPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation
import UIKit
import WebKit

final class LoginPresenter {
    
    weak var view: LoginViewControllerInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    //ID нашего приложения в API VK
    let appId = "8137039"
    
    init(vc: LoginFormController) {
        self.view = vc
        let router = LoginRouter()
        let interactor = LoginInteractor()
        
        interactor.output = self
        self.interactor = interactor
        
//        router.output = self
        self.router = router
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginSuccess() {
        router.showTabBarController(from: view.getVC())
    }
}

extension LoginPresenter: LoginViewControllerOutput {
    func viewIsReady() {
        guard let url = URL (string: "https://oauth.vk.com/authorize?client_id=" + self.appId + "display=page&redirect_url=https://oauth.vk.com/blank.html&scope=friends,groups,photos&response_type=token&v=5.131state=123456") else { return }
        let requestObj = URLRequest (url: url)
        self.view.loadWebView(requestObj)
    }
    
    func authVK(decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        self.interactor.authVK(decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)
        
    }
}
