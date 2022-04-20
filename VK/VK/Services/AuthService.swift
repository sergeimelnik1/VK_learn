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
       
    public static func loadFriendList(success: @escaping ([Friend]) -> ()) {
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
//                print(json)
                success(friends)
                //тут мы данные сохраняем в Realm
//                self.saveFriendsData(friend: friends)
//                print(json)
                //тут отправка инфы, что данные поменялись
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadWeathers"), object: weathers)
                
            } catch {
                print(error)
            }
        }
        
    }

    public static func loadGroupList(success: @escaping ([Group]) -> ()) {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v": "5.131",
            "extended" : "1",
            "count": "100",
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
                success(groups)
                //тут мы данные сохраняем в Realm
//                self.saveData(data: groups)
//                print("Выгрузка по группам")
//                print(json)
                //тут отправка инфы, что данные поменялись
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadWeathers"), object: weathers)
                
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
        
        AF.request(url, method: .get, parameters: parameters).responseData { [self] repsons in
            do {
                guard let data = repsons.value else { return }
                let json = try JSON(data: data)
                
                let searchGroups: [Group] = json["response"]["items"].arrayValue.compactMap { Group(with: $0) }
                success(searchGroups)
                //тут отправка инфы, что данные поменялись
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadWeathers"), object: weathers)
                
            } catch {
                print(error)
            }
        }
    }
    
    // сохранение погодных данных в realm
//    func saveFriendsData(friend: [Friend]) {
//        // обработка исключений при работе с хранилищем
//        do {
//            // получаем доступ к хранилищу
//            let realm = try Realm()
//            // получаем друзей
//
//
//            guard let friends = realm.objects(Friend) else { return }
//            // все старые погодные данные для текущего города
//            let oldFriends = friends
//            // начинаем изменять хранилище
//            realm.beginWrite()
//            // удаляем старые данные
//            realm.delete(oldFriends)
//            // кладем все объекты класса погоды в хранилище
//            friends.append(contentsOf: friend)
//            // завершаем изменять хранилище
//            try realm.commitWrite()
//        } catch {
//            // если произошла ошибка, выводим ее в консоль
//            print(error)
//        }
//    }
}
//func addNewSpecimen() {
//  let realm = try! Realm() // 1
//
//  try! realm.write { // 2
//    let newSpecimen = Specimen() // 3
//
//    newSpecimen.name = self.nameTextField.text! // 4
//    newSpecimen.category = self.selectedCategory
//    newSpecimen.specimenDescription = self.descriptionTextField.text
//    newSpecimen.latitude = self.selectedAnnotation.coordinate.latitude
//    newSpecimen.longitude = self.selectedAnnotation.coordinate.longitude
//
//    realm.add(newSpecimen) // 5
//    self.specimen = newSpecimen // 6
//  }
//}
