//
//  Coordinator.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit
import KLBreakingBadAPI


/**
 Coordinator will help navigate between the
 different screen of the application
 */
protocol Coordinator : class {
    var navigationController: UINavigationController {get set}
    func start()
}


class MainCoordinator : Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CharacterListController()
        vc.mainCoordinator = self
        vc.presenter = CharacterListViewPresenterImpl(breakingBadAPIClient: BreakingBadRestApiClient())
        navigationController.pushViewController(vc, animated: false)
    }

    func openQuoteViewControllerFor(characterName: String?) {
        let vc = QuoteController()
        vc.mainCoordinator = self
        vc.presenter = QuotePresenterImpl(breakingBadAPIClient: BreakingBadRestApiClient(), author: characterName)
        navigationController.pushViewController(vc, animated: true)
    }

    func showErrorDialog(from: UIViewController, error: Error, completion: (()->())? = nil ) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

        let dismissAction =  UIAlertAction(title: "OK", style:UIAlertAction.Style.destructive)
        alert.addAction(dismissAction)
        navigationController.present(alert, animated: true, completion: completion)
    }

    func showShareTextCapabilities(_ textToShare: String) {
        let activityItems = [textToShare]
        let activityController = UIActivityViewController(activityItems: activityItems , applicationActivities: nil)
        navigationController.present(activityController, animated: true, completion: nil)
    }
    
}
