//
//  OtherGroupsConfig.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

class OtherGroupsConfig {
    
    var view : OtherGroupsViewInput?
    let presenter = OtherGroupsPresenter()
    
    init() {
        let storyboard: UIStoryboard = UIStoryboard(name: "OtherGroupsController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OtherGroupsViewController") as! OtherGroupsViewController
        viewController.modalPresentationStyle = .fullScreen
        
        view = viewController
        let interactor = OtherGroupsInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
                
        view?.output = presenter
        presenter.view = view
    }
}

extension OtherGroupsConfig: OtherGroupsConfigInput {
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
