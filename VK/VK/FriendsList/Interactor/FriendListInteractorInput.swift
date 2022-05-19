//
//  FriendListInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

protocol FriendListInteractorInput: AnyObject {
    var output: FriendListInteractorOutput? { get set }
    
    func loadData()
}
