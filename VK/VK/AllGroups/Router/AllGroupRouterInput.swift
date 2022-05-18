//
//  AllGroupRouterInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

protocol AllGroupsRouterInput {
    
    func openOtherGroups(_ vc: UIViewController)
    func showLoadGroupsError(_ error: Error, _ vc: UIViewController)
}
