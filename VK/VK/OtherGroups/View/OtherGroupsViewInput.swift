//
//  OtherGroupsViewInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

protocol OtherGroupsViewInput {
    
    var output: OtherGroupsViewOutput? { get set }
    func getVC() -> UIViewController
    
}
