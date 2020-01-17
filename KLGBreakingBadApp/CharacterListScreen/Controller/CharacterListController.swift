//
//  CharacterListController.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit
import KLBreakingBadAPI

protocol CharacterListView: NSObjectProtocol {
    func showError(_ error: Error)
    func refreshListOfItems(newList: [String])
    func openQuoteScreen(forCharacter character: String?)
    func startLoading()
    func endLoading()
}

class CharacterListController: UIViewController, CharacterListView {

    weak var mainCoordinator: MainCoordinator?

    var presenter: CharacterListViewPresenter!

    var charactersName: [String] = []

    var tableView: UITableView!

    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        self.initUI()
        presenter.attachView(self)
        presenter.onLoadListRequest()
    }

    func refreshListOfItems(newList: [String]) {
        self.charactersName = newList
        refreshControl.endRefreshing()
        tableView.reloadData()
    }

    func startLoading() {
        refreshControl.beginRefreshing()
    }

    func endLoading(){
        refreshControl.endRefreshing()
    }

    func showError(_ error: Error) {
        refreshControl.endRefreshing()
        self.mainCoordinator?.showErrorDialog(from: self, error: error)
    }

    func openQuoteScreen(forCharacter character: String?) {
        mainCoordinator?.openQuoteViewControllerFor(characterName: character)
    }

    @objc
    func onRandomTapped() {
        presenter.onRandomTapped()
    }

    @objc func triggerRefresh() {
        presenter.onLoadListRequest()
    }

}


/// DataSource
extension CharacterListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CharacterCell")

        let userViewData = charactersName[indexPath.row]
        cell.textLabel?.text = userViewData
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }

}


/// TableViewDelegate
extension CharacterListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onCharcterTapped(character: charactersName[indexPath.row])
    }
    
}




