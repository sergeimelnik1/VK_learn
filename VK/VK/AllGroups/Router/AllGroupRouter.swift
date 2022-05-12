//
//  AllGroupRouter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

class AllGroupsRouter: AllGroupsRouterInput {
    func showLoadGroupsError(_ error: Error) {
        print(error)
    }
    
    func openOtherGroups(_ vc: UIViewController) {
        OtherGroupsConfig().present(from: vc)
    }
    
    var output: AllGroupsRouterOutput?
    
}
