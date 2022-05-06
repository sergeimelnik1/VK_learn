//
//  LoginInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import Foundation
import WebKit

protocol LoginInteractorInput {
    func authVK(decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
}
