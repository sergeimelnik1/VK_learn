//
//  AllGroupInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

protocol AllGroupsInteractorInput {
    var output: AllGroupsInteractorOutput? { get set }
    func loadGroups()
}
