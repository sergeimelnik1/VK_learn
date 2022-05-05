//
//  LoginFormInput.swift
//  VK
//
//  Created by Sergey Melnik on 04.05.2022.
//

import UIKit

protocol LoginFormInput {
    var output: LoginFormOutput? { get set }
    func getVC() -> UIViewController

}
