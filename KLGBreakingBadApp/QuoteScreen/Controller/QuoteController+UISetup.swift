//
//  QuoteController+UISetup.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 16/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit

internal extension QuoteController {

    func initUI() {
        view.backgroundColor = .white
        self.setNavigationBar()
        initStackView()
        initQuoteLabel()
        initAuthorLabel()
        setupConstraint()
    }

    func initStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        view.addSubview(stackView)
    }

    func initQuoteLabel() {
        mainText = UILabel()
        mainText.numberOfLines = 0
        mainText.textColor = .black
        mainText.accessibilityIdentifier = "label_quote_main_text"
        mainText.textAlignment = .center
        mainText.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(mainText)
    }

    func initAuthorLabel() {
        subtitle = UILabel()
        subtitle.numberOfLines = 0
        subtitle.textColor = .black
        subtitle.accessibilityIdentifier = "label_quote_main_author"
        subtitle.font = subtitle.font.withSize(12)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(subtitle)
    }

    func setupConstraint() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            mainText.widthAnchor.constraint(lessThanOrEqualToConstant:256)
        ])
    }

    func setNavigationBar() {
        self.navigationItem.title = "Quotes"
    }

}
