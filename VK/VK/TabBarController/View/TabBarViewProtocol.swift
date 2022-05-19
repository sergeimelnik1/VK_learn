//
//  TabBarProtocol.swift
//  VK
//
//  Created by Sergey Melnik on 16.05.2022.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    
    var title: String { get }
    var image: UIImage? { get }
    
    func configured() -> UIViewController
}
