//
//  OtherGroupsInteractorOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import SwiftUI

protocol OtherGroupsInteractorOutput: AnyObject {
    func sendSearchDataToView(_ searchText: String, groups: [GroupModel])
}
