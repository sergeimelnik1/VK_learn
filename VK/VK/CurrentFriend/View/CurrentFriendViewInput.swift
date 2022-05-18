//
//  CurrentFriendViewInput.swift
//  VK
//
//  Created by Sergey Melnik on 26.04.2022.
//

import UIKit

protocol CurrentFriendViewInput {
    var output: CurrentFriendViewOutput? { get set }

    func getVC() -> UIViewController
}
