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
    
    init(){
        let storyboard: UIStoryboard = UIStoryboard(name: "OtherGroupsController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OtherGroupsViewController") as! OtherGroupsViewController
        viewController.modalPresentationStyle = .fullScreen
        
        view = viewController
        let router = OtherGroupsRouter()
        let interactor = OtherGroupsInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view?.output = presenter
        presenter.view = view
    }
}
protocol OtherGroupsConfigInput {
    func present(from vc: UIViewController)
}

extension OtherGroupsConfig: OtherGroupsConfigInput {
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
    
    
}
