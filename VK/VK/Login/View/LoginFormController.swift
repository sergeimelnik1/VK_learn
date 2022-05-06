//
//  LoginFormController.swift
//  VK
//
//  Created by Sergey Melnik on 11.04.2022.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    var output: LoginViewOutput?
    
    //ID нашего приложения в API VK
    let appId = "8137039"
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        output = LoginPresenter(vc: self)
        guard let url = URL (string: "https://oauth.vk.com/authorize?client_id=" + appId + "display=page&redirect_url=https://oauth.vk.com/blank.html&scope=friends,groups,photos&response_type=token&v=5.131state=123456") else { return }
        let requestObj = URLRequest (url: url)
        webView.load(requestObj)
    }
}

extension LoginFormController: WKNavigationDelegate {
//    self.output?.authVK()
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        self.output?.authVK(decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)
    }
}
extension LoginFormController: LoginViewInput {
    func getVC() -> UIViewController {
        return self
    }
}
