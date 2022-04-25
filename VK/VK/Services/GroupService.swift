//
//  GroupService.swift
//  VK
//
//  Created by Sergey Melnik on 20.04.2022.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class GroupService {
    
    var token: NotificationToken?
    
    public static func loadGroupList(success: @escaping () -> ()) {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v": "5.131",
            "extended" : "1",
            "count": "50",
            "fields" : ["name", "photo_50"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        //выходит сразу же после попадания в строчку ниже, даже не скачивая данные
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                print(json)
                let groups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
                //тут мы данные сохраняем в Realm
                self.saveGroupsData(groups)
                success()
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
                print(searchGroups)
                success(searchGroups)
            } catch {
                print(error)
            }
        }
    }
    //подписка на группу по ID
    public static func followGroup(groupId: Int, success: @escaping () -> ()) {
        let url = "https://api.vk.com/method/groups.join"
        let parameters: Parameters = [
            "v": "5.131",
            "group_id" : groupId,
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                print(json)
                let groups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
                success()
//                //тут мы данные сохраняем в Realm
//                self.saveGroupsData(groups)
            } catch {
                print(error)
            }
        }
    }
    //покинуть группу по ID
    public static func leaveGroup(groupId: Int, success: @escaping () -> ()) {
        let url = "https://api.vk.com/method/groups.leave"
        let parameters: Parameters = [
            "v": "5.131",
            "group_id" : groupId,
            "access_token": Singleton.sharedInstance().accessToken
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                success()
//                print(json)
//                let groups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
            } catch {
                print(error)
            }
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
            print(realm.configuration.fileURL)
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
