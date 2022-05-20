//
//  OtherGroupsInteractorOutput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation
import SwiftUI

protocol OtherGroupsInteractorOutput: AnyObject {
    func success(groups: [GroupModel])
    func error(_ error: String)
}
