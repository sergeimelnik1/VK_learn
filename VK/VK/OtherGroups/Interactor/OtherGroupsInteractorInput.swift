//
//  OtherGroupsInteractorInput.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

protocol OtherGroupsInteractorInput: AnyObject {
    var output: OtherGroupsInteractorOutput? { get set }
    
    func loadSearchData(_ searchText: String)
    func followGroup(_ groupId: Int, _ currentSearchText: String)
    func leaveGroup(_ groupId: Int, _ currentSearchText: String)
}
