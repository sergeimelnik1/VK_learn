//
//  AllGroupPresenter.swift
//  VK
//
//  Created by Sergey Melnik on 28.04.2022.
//

import Foundation

class AllGroupsPresenter {
    
        var view: AllGroupsViewInput!
        var interactor: AllGroupsInteractorInput!
        var router: AllGroupsRouterInput!
        
    }

    extension AllGroupsPresenter: AllGroupsInteractorOutput {
        
    }

    extension AllGroupsPresenter: AllGroupsRouterOutput {
        
    }

extension AllGroupsPresenter: AllGroupsViewOutput {
    func openOtherGroups() {
        self.router.openOtherGroups(from: view.getVC())
    }
    
    func viewIsReady() {

    }
    

    }

