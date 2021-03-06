//
//  OtherGroupsViewInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import UIKit

protocol OtherGroupsViewInput: AnyObject {
    
    var output: OtherGroupsViewOutput? { get set }
    
    func onActivityIndicator()
    func offActivityIndicator()
    func getVC() -> UIViewController
    func reload()
}
