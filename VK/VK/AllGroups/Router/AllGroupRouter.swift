//
//  AllGroupRouter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

class AllGroupsRouter: AllGroupsRouterInput {
    func showLoadGroupsError(_ error: Error, _ vc: UIViewController) {
        let alert = UIAlertController(title: "ОШИБКА ПОДГРУЗКИ", message: "ВЕРНИСЬ НАЗАД", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func openOtherGroups(_ vc: UIViewController) {
        OtherGroupsConfig().present(from: vc)
    }
}
