//
//  LoginFormController.swift
//  VK
//
//  Created by Sergey Melnik on 11.04.2022.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    var output: LoginViewControllerOutput?
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
        //вынести в презентер в метод через протокол

        self.output?.viewIsReady()
    }
}

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        self.output?.authVK(decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)
    }
}

extension LoginFormController: LoginViewControllerInput {
    func loadWebView(_ url: URLRequest) {
        webView.load(url)
    }
    
    func getVC() -> UIViewController {
        return self
    }
}
