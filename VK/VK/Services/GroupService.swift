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

final class GroupService: GroupServiceProtocol {
    
    private var token: NotificationToken?
    
    func loadGroupList(success: @escaping () -> (), fail: @escaping (Error) -> ()) {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v": "5.131",
            "extended" : "1",
            "count": "50",
            "fields" : ["name", "photo_50"],
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsonse in
            do {
                guard let data = repsonse.value else { return }
                let json = try JSON(data: data)
                let groups: [GroupModel] = json["response"]["items"].arrayValue.compactMap { GroupModel(with: $0) }
                self.saveGroupsData(groups)
                success()
            } catch {
                fail(error)
            }
        }
    }
    
    func loadSearchGroupList(query: String, success: @escaping ([GroupModel]) -> (), fail: @escaping (Error) -> ()) {
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "v": "5.131",
            "q": query,
            "sort" : "0",
            "count": "20",
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { repsonse in
            do {
                guard let data = repsonse.value else { return }
                let json = try JSON(data: data)
                let searchGroups: [GroupModel] = json["response"]["items"].arrayValue.compactMap { GroupModel(with: $0) }
                success(searchGroups)
            } catch {
                fail(error)
            }
        }
    }
    
    //подписка на группу по ID
    func followGroup(groupId: Int, success: @escaping () -> (), fail: @escaping (Error) -> ()) {
        let url = "https://api.vk.com/method/groups.join"
        let parameters: Parameters = [
            "v": "5.131",
            "group_id" : groupId,
            "access_token": Singleton.sharedInstance().accessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { repsons in
            do {
                guard let data = repsons.value else { return }
                _ = try JSON(data: data)
                success()
            } catch {
                fail(error)
            }
        }
    }
    
    //покинуть группу по ID
    func leaveGroup(groupId: Int, success: @escaping () -> (), fail: @escaping (Error) -> ()) {
        let url = "https://api.vk.com/method/groups.leave"
        let parameters: Parameters = [
            "v": "5.131",
            "group_id" : groupId,
            "access_token": Singleton.sharedInstance().accessToken
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { repsonse in
            do {
                guard let data = repsonse.value else { return }
                _ = try JSON(data: data)
                success()
            } catch {
                fail(error)
            }
        }
    }
    
    //сохранение групп в realm
    private func saveGroupsData(_ groups: [GroupModel]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            // все старые данные друзей
            let oldGroups = realm.objects(GroupModel.self)
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
