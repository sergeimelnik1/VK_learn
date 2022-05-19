//
//  Group.swift
//  VK
//
//  Created by Sergey Melnik on 13.04.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

final class GroupModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image50 = ""
    @objc dynamic var is_member = 0
    
    func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image50 = json["photo_50"].stringValue
        self.is_member = json["is_member"].intValue
    }
}
