//
//  AllGroupViewInput.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import UIKit

protocol AllGroupsViewInput: AnyObject {
    var output: AllGroupsViewOutput? { get set }
    
    func getVC() -> UIViewController
    func reload()
    func onActivityIndicator()
    func offActivityIndicator()
}
