//
//  CharacterListPresenter.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 16/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import Foundation
import KLBreakingBadAPI

protocol  CharacterListViewPresenter {
    func onLoadListRequest()
    func onCharcterTapped(character: String)
    func attachView(_ v: CharacterListView)
    func onRandomTapped()
}

class CharacterListViewPresenterImpl: CharacterListViewPresenter {

    let  breakingBadService: BreakingBadApiClient

    weak private var view: CharacterListView?

    init (breakingBadAPIClient: BreakingBadApiClient) {
        self.breakingBadService = breakingBadAPIClient
    }

    func onLoadListRequest() {
        view?.startLoading()

        breakingBadService.allTVCharacters { [weak self] response in
            
            let transformedList = response.data?.map { character in
                character.name
            }

            DispatchQueue.main.async {
                self?.view?.endLoading()
                if let err = response.error  {
                    self?.view?.showError(err)
                } else {
                    self?.view?.refreshListOfItems(newList: transformedList ?? [] )
                }
            }
            
        }
    }

    func attachView(_ v: CharacterListView) {
        self.view = v
    }
    
    func onCharcterTapped(character: String) {
        view?.openQuoteScreen(forCharacter: character)
    }

    func onRandomTapped() {
        view?.openQuoteScreen(forCharacter: nil)
    }

}
