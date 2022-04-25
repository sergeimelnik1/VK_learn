//
//  Singleton.swift
//  VK
//
//  Created by Sergey Melnik on 20.04.2022.
//

import Foundation

class Singleton {

    var accessToken: String
    var userId: String

    static let shared = Singleton()
    public static func sharedInstance() -> Singleton {
        return .shared
        }
    init() {
        self.accessToken = ""
        self.userId = ""
    }
}
