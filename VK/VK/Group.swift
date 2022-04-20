//
//  Group.swift
//  VK
//
//  Created by Sergey Melnik on 13.04.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image50 = ""
    
    convenience init(with json: JSON) {
        self.init()
        func primaryKey() -> String? {
                return "id"
            }
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image50 = json["photo_50"].stringValue
    }
}
