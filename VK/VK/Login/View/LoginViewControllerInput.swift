//
//  LoginFormInput.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import UIKit

protocol LoginViewControllerInput: AnyObject {
    var output: LoginViewControllerOutput? { get set }
    
    func getVC() -> UIViewController
    func loadWebView(_ url: URLRequest)
}
