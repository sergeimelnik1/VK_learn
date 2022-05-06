//
//  LoginFormOutput.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation
import WebKit

protocol LoginViewOutput {
//    func loginSuccess()
    func authVK(decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
}
