//
//  AllGroupInteractorOutput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation
import RealmSwift

protocol AllGroupsInteractorOutput {
    func loadGroupsSuccess(_ groups: Results<Group>)
    func loadGroupsError(_ error: Error)
}
