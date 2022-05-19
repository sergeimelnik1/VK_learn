//
//  Friend.swift
//  VK
//
//  Created by Sergey Melnik on 13.04.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

final class FriendModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image50 = ""
    @objc dynamic var image200 = ""
    
    func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue + " " + json["last_name"].stringValue
        self.image50 = json["photo_50"].stringValue
        self.image200 = json["photo_200_orig"].stringValue
    }
}
