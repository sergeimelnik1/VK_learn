//
//  OtherGroupsInteractor.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

class OtherGroupsInteractor : OtherGroupsInteractorInput {
    func loadSearchData(_ searchText: String) {
        if searchText != "" {
            GroupService().loadSearchGroupList(query: searchText, success: { [weak self] groups in
                self?.output?.sendSearchDataToView(searchText, groups: groups)
            })
        } else {
            self.output?.sendSearchDataToView(searchText, groups: [])
        }
    }
    
    
    var output : OtherGroupsInteractorOutput?
    
}
