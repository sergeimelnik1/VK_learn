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

class AuthService {
    
    public static func loadFriendList() {
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "v": "5.131",
            "count": "100",
            "order": "hints",
            "fields" : ["nickname", "photo_50", "photo_200_orig"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                let friends: [Friend] = json["response"]["items"].arrayValue.compactMap { Friend(with: $0) }
                //тут мы данные сохраняем в Realm
                self.saveFriendsData(friends)
            } catch {
                print(error)
            }
        }
        
    }
    
    public static func loadGroupList() {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v": "5.131",
            "extended" : "1",
            "count": "50",
            "fields" : ["name", "photo_50"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                print(json)
                //ошибка в строке ниже
                let groups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
                //тут мы данные сохраняем в Realm
                self.saveGroupsData(groups)
            } catch {
                print(error)
            }
        }
    }
    
    public static func loadSearchGroupList(query: String, success: @escaping ([Group]) -> ()) {
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "v": "5.131",
            "q": query,
            "sort" : "0",
            "count": "20",
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                let searchGroups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
                success(searchGroups)
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
    
    //сохранение групп в realm
    private static func saveGroupsData(_ groups: [Group]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            // все старые данные друзей
            let oldGroups = realm.objects(Group.self)
            // начинаем изменять хранилище
            realm.beginWrite()
            //удаляем старые данные
            realm.delete(oldGroups)
            // кладем все объекты класса друзей в хранилище
            realm.add(groups)
            // завершаем изменять хранилище
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
