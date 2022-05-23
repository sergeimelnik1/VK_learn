//
//  CurrentFriendConfig.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import UIKit

final class CurrentFriendConfig {
    
    var view : CurrentFriendViewInput
    let presenter = CurrentFriendPresenter()
    
    init(friend: FriendModel) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CurrentFriendViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrentFriendViewController") as! CurrentFriendViewController
        viewController.modalPresentationStyle = .fullScreen
        
        presenter.friend = friend
        view = viewController
        view.output = presenter
        presenter.view = view
    }
}
extension CurrentFriendConfig: CurrentFriendConfigInput {
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
