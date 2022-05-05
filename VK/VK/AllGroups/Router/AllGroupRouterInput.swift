//
//  AllGroupRouterInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

protocol AllGroupsRouterInput {
    
    var output: AllGroupsRouterOutput? { get set }
    func openOtherGroups(from vc: UIViewController)

}
