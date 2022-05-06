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
    
    func openOtherGroups(from vc: UIViewController) {
        let storyboard: UIStoryboard = UIStoryboard(name: "OtherGroupsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OtherGroupsVC") as! OtherGroupsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.present(vc, animated: false, completion: nil)
    }

    
    var output: AllGroupsRouterOutput?
    
}
