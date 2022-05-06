//
//  FriendListConfig.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

class FriendListConfig: TabBarViewProtocol {
    var title: String = "Друзья"
    
    var image: UIImage? = UIImage(named: "")
    
    func configured() -> UIViewController {
        return view.getVC()
    }
    
    
    var view : FriendListViewInput
    let presenter = FriendListPresenter()
    
    init(){
        let storyboard: UIStoryboard = UIStoryboard(name: "FriendsListViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FriendsListViewController") as! FriendsListViewController
        vc.modalPresentationStyle = .fullScreen
        
        view = vc
//        view = FriendListViewController()
        let router = FriendListRouter()
        let interactor = FriendListInteractor()
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.output = presenter
        presenter.router = router
        
        view.output = presenter
        presenter.view = view
    }
}
