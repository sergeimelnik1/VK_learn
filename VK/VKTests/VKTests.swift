//
//  VKTests.swift
//  VKTests
//
//  Created by Sergey Melnik on 16.05.2022.
//

import XCTest
import Alamofire
import SwiftyJSON
import RealmSwift


class VKTests: XCTestCase {
    func loadGroupList() {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v": "5.131",
            "extended" : "1",
            "count": "50",
            "fields" : ["name", "photo_50"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        //выходит сразу же после попадания в строчку ниже, даже не скачивая данные
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsonse in
            do {
                guard let data = repsonse.value else { return }
                let json = try JSON(data: data)
                let groups: [GroupModel] = json["response"]["items"].arrayValue.compactMap { GroupModel(with: $0) }
                self.saveGroupsData(groups)
                success()
            } catch {
                print(error)
            }
        }
    }

}
