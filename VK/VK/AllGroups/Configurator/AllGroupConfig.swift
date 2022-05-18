//
//  AllGroupConfigurator.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

class AllGroupsConfig: TabBarViewProtocol {
    var title: String = "Группы"
    var image: UIImage? = UIImage(named: "groups")
    
    func configured() -> UIViewController {
        return view.getVC()
    }
    
    var view : AllGroupsViewInput
    let presenter = AllGroupsPresenter()
    
    init() {
        let storyboard: UIStoryboard = UIStoryboard(name: "AllGroupsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AllGroupsViewController") as! AllGroupsViewController
        vc.modalPresentationStyle = .fullScreen
        
        view = vc
        let router = AllGroupsRouter()
        let interactor = AllGroupsInteractor()
        interactor.groupService = GroupService()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        presenter.router = router

        view.output = presenter
        presenter.view = view
    }
}
