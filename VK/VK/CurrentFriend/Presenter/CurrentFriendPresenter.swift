//
//  CurrentFriendPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import UIKit

class CurrentFriendPresenter {
    
    weak var view: CurrentFriendViewInput!
    var friend: FriendModel!
}

extension CurrentFriendPresenter: CurrentFriendViewOutput {
    func setFriendValue(_ friend: FriendModel) {
        self.friend = friend
    }
    
    func getFriendValue() -> FriendModel? {
        return self.friend
    }
    
    func viewIsReady() {
        
    }
}
extension CurrentFriendPresenter {
    func present(from vc: UIViewController) {
        vc.present(view as! UIViewController, animated: true, completion: nil)
    }
}

