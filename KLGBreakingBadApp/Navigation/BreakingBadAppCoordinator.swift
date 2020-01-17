//
//  BreakingBadAppCoordinator.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import Foundation
import UIKit

class CharacterListCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?

    init(navigationController :UINavigationController?) {
        self.navigationController = navigationController
    }

    override func start() {

        // prepare the associated view and injecting its viewModel
        let viewModel = CharacterListViewModel()
        let viewController = CharacterListController(viewModel: viewModel)

//        // for specific events from viewModel, define next navigation
//        viewModel.didSelect = { [weak self] product in
//            guard let strongSelf = self else { return }
//            strongSelf.showDetail(product, in: strongSelf.navigationController)
//        }

        // if user navigates back, view should be released, so does the coordinator, flow is completed
//        viewModel.didTapBack = { [weak self] in
//            self?.isCompleted?()
//        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    // we can go further in our flow if we need to
//    func showDetail(_ product: Product, in navigationController: UINavigationController?) {
//        let newCoordinator = NewCoordinator(product: product, navigationController: navigationController)
//        self.store(coordinator: newCoordinator)
//    }
}
