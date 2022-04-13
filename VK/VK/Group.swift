//
//  Group.swift
//  VK
//
//  Created by Sergey Melnik on 13.04.2022.
//

import Foundation

struct Group {
    
    var name: String
    var type: GroupType
}

enum GroupType: String {
    case myGroup = "Мои группы"
    case allGroup = "Все группы"
}
