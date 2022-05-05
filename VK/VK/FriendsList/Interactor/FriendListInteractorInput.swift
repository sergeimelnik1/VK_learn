//
//  FriendListInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

protocol FriendListInteractorInput {
    var output: FriendListInteractorOutput? { get set }
    
    func loadData()
}
