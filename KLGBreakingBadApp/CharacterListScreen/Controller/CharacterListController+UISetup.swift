//
//  CharacterListController+UISetup.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 16/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit


internal extension CharacterListController {

    func initUI() {
        view.backgroundColor = .white
        self.setNavigationBar()
        self.initTableView()
        self.initConstraints()
    }

    func setNavigationBar() {
        self.navigationItem.title = "Breaking Bad"
        let rightButtonItem = UIBarButtonItem(title: "Random Quote", style: .plain, target: self, action: #selector(onRandomTapped))
        rightButtonItem.accessibilityIdentifier = "but_random_quote "
        navigationItem.rightBarButtonItem = rightButtonItem
    }

    func initTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.accessibilityIdentifier = "table_characters"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(triggerRefresh), for: .valueChanged
        )
        tableView.dataSource = self
        tableView.delegate = self
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
