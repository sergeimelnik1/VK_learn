//
//  OtherGroupsPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 27.04.2022.
//

import Foundation

class OtherGroupsPresenter {
    
        weak var view: OtherGroupsViewInput!
        var interactor: OtherGroupsInteractorInput!
        var router: OtherGroupsRouterInput!
        
    }

extension OtherGroupsPresenter: OtherGroupsInteractorOutput {
    func sendSearchDataToView(_ searchText: String, groups: [Group]) {
        view.loadSearchData(searchText, groups: groups)
    }
    
        
    }

    extension OtherGroupsPresenter: OtherGroupsRouterOutput {
        
    }

extension OtherGroupsPresenter: OtherGroupsViewOutput {
    func filterContentForSearchText(_ searchText: String) {
        self.interactor.loadSearchData(searchText)
    }
    
    func viewIsReady() {
    
    }
    

    }

