//
//  LoginInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import UIKit
import WebKit

final class LoginInteractor: LoginInteractorInput {
    
    var output : LoginInteractorOutput?
    
    func authVK(decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let urlComponents = fragment.components(separatedBy: "&").map{ $0.components(separatedBy: "=")}
        let token = urlComponents.first {$0.first == "access_token"}?.last
        let userId = urlComponents.first {$0.first == "user_id"}?.last ?? "0"
        guard let accessToken = token else {
            decisionHandler(.allow)
            return
        }
        let userDefaults = UserDefaults.standard //настройки пользователя
        userDefaults.set(accessToken, forKey: "accessToken")
        userDefaults.set(userId, forKey: "userId")
        Singleton.sharedInstance().accessToken = accessToken
        Singleton.sharedInstance().userId = userId
        output?.loginSuccess()
        decisionHandler(.cancel)
    }
}
