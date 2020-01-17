//
//  QuoteController.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit
import Foundation

protocol  QuoteView: NSObjectProtocol  {
    func showError(_ err: Error)
    func startLoading()
    func stopLoading()
    func showQuoteText(quote: String)
    func showQuoteAuthot(author: String)
    func activateShareButton()
    func onNoQuoteFound()
    func showShareView(textToShare: String)
}

class QuoteController: UIViewController, QuoteView {

    weak var mainCoordinator: MainCoordinator?

    var presenter: QuotePresenter!

    var mainText: UILabel!

    var subtitle: UILabel!

    var stackView: UIStackView!

    override func viewDidLoad() {
        initUI()
        presenter.attachView(self)
        presenter.loadQuote()
    }

    func showQuoteText(quote: String) {
        mainText.text = quote
    }

    func showQuoteAuthot(author: String) {
        subtitle.text = author
    }

    func onNoQuoteFound() {
        mainText.text = "No quote found"
    }

    func showError(_ err: Error) {
        mainText.text = err.localizedDescription
    }

    func activateShareButton() {
        let btnShare = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem = btnShare
    }

    func startLoading() {
        mainText.text = "Loading quote"
    }

    func stopLoading() {}

    @objc func share() {
        presenter.onShareTapped()
    }

    func showShareView(textToShare: String) {
        mainCoordinator?.showShareTextCapabilities(textToShare)
    }

}

