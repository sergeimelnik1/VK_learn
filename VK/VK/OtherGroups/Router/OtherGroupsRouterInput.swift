//
//  OtherGroupsRouterInput.swift
//  VK
//
//  Created by Sergey Melnik on 20.05.2022.
//

import UIKit

protocol OtherGroupsRouterInput: AnyObject {
    func showLoadGroupsError(_ error: Error, _ vc: UIViewController)
}
