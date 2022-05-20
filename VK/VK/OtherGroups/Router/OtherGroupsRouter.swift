//
//  OtherGroupsRouter.swift
//  VK
//
//  Created by Sergey Melnik on 20.05.2022.
//

import UIKit

final class OtherGroupsRouter: OtherGroupsRouterInput {
    
    func showLoadGroupsError(_ error: String, _ vc: UIViewController) {
        let alert = UIAlertController(title: error, message: "ВЕРНИСЬ НАЗАД", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
