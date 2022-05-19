//
//  Singleton.swift
//  VK
//
//  Created by Sergey Melnik on 20.04.2022.
//

import Foundation

final class Singleton {
    
    var accessToken: String = ""
    var userId: String = ""
    
    private static let singleton = Singleton()
    
    public static func sharedInstance() -> Singleton {
        return .singleton
    }
}
