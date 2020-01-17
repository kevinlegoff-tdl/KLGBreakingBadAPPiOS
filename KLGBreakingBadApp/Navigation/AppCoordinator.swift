//
//  AppCoordinator.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let myCoordinator = MyCoordinator(navigationController: navigationController)

        // store child coordinator
        self.store(coordinator: myCoordinator)
        myCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        myCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }
    }
}
