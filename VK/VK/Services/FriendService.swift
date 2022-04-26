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

class FriendService {
    var token: NotificationToken?

    public static func loadFriendList() {
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "v": "5.131",
            "count": "20",
            "order": "hints",
            "fields" : ["nickname", "photo_50", "photo_200_orig"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsonse in
            do {
                guard let data = repsonse.value else { return }
                let json = try JSON(data: data)
                let friends: [Friend] = json["response"]["items"].arrayValue.compactMap { Friend(with: $0) }
                //тут мы данные сохраняем в Realm
                self.saveFriendsData(friends)
            } catch {
                print(error)
            }
        }
        
    }
    
    //сохранение друзей в realm
    private static func saveFriendsData(_ friends: [Friend]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            // все старые данные друзей
            let oldFriends = realm.objects(Friend.self)
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
