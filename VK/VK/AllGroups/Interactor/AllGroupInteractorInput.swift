//
//  AllGroupInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

protocol AllGroupsInteractorInput: AnyObject {
    var output: AllGroupsInteractorOutput? { get set }
    
    func loadGroups()
    func leaveGroup(_ groupId: Int)
}
