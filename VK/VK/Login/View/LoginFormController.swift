//
//  LoginFormController.swift
//  VK
//
//  Created by Sergey Melnik on 11.04.2022.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    var output : LoginFormOutput?

    //ID нашего приложения в API VK
    private let appId = "8137039"
    private var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        guard let url = URL (string: "https://oauth.vk.com/authorize?client_id=" + appId + "display=page&redirect_url=https://oauth.vk.com/blank.html&scope=friends,groups,photos&response_type=token&v=5.131state=123456") else { return }
        let requestObj = URLRequest (url: url)
        webView.load(requestObj)
    }
}

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
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
        print(accessToken)
        Singleton.sharedInstance().userId = userId
        decisionHandler(.cancel)
        performSegue(withIdentifier: "loginSuccess", sender: self)
    }
}
extension LoginFormController: LoginFormInput {
    func getVC() -> UIViewController {
        return self
    }
}
