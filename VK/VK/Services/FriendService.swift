//
//  AuthService.swift
//  VK
//
//  Created by Sergey Melnik on 15.04.2022.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class FriendService: FriendServiceProtocol {
    var token: NotificationToken?
    
    static func loadFriendList() {
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "v": "5.131",
            "count": "50",
            "order": "hints",
            "fields" : ["nickname", "photo_50", "photo_200_orig"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsonse in
            do {
                guard let data = repsonse.value else { return }
                let json = try JSON(data: data)
                let friends: [FriendModel] = json["response"]["items"].arrayValue.compactMap { FriendModel(with: $0) }
                print(friends)
                //тут мы данные сохраняем в Realm
                self.saveFriendsData(friends)
            } catch {
                print(error)
            }
        }
        
    }
    
    //сохранение друзей в realm
    static func saveFriendsData(_ friends: [FriendModel]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            // все старые данные друзей
            let oldFriends = realm.objects(FriendModel.self)
            // начинаем изменять хранилище
            realm.beginWrite()
            //удаляем старые данные
            realm.delete(oldFriends)
            // кладем все объекты класса друзей в хранилище
            realm.add(friends)
            // завершаем изменять хранилище
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
