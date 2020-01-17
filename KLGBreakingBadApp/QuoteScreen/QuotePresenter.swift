//
//  QuotePresenter.swift
//  KLGBreakingBadApp
//
//  Created by Kevin Le Goff on 16/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import Foundation
import KLBreakingBadAPI

protocol QuotePresenter {
    func loadQuote()
    func attachView(_ quoteView: QuoteView)
    func onShareTapped()
}

class QuotePresenterImpl: QuotePresenter {

    weak var view: QuoteView?

    let breakingBadService: BreakingBadApiClient

    let author : String?

    var quote: Quote?

    lazy var onQuoteLoadedCallback: QuoteCallback  = { [weak self] response in

        DispatchQueue.main.async {
            self?.view?.stopLoading()
            if let err = response.error {
                switch err  {
                case BreakingBadApiClientError.noQuoteForThisCharacter :
                    self?.view?.onNoQuoteFound()
                default:
                    self?.view?.showError(err)
                }
            } else {
                guard let quote = response.data else {
                    fatalError("We received no error but we still have a null quote")
                }
                self?.quote = quote
                self?.view?.showQuoteText(quote: quote.quote)
                self?.view?.showQuoteAuthot(author: quote.author)
                self?.view?.activateShareButton()
            }
        }
    }

    init (breakingBadAPIClient: BreakingBadApiClient, author: String? = nil) {
        self.breakingBadService = breakingBadAPIClient
        self.author = author
    }

    func attachView(_ quoteView: QuoteView) {
        self.view = quoteView
    }

    func loadQuote() {
        view?.startLoading()
        if let author = author  {
            self.breakingBadService.randomQuote(fromCharacterWithName: author, onQuoteLoadedCallback)
        } else {
            self.breakingBadService.randomQuote(onQuoteLoadedCallback)
        }
    }

    func onShareTapped() {
        guard let quote = quote else {
            return
        }
        view?.showShareView(textToShare: quote.formatForSharing)
    }
    
}

private extension Quote {
    var formatForSharing: String {
        return "\(quote) // \(author)"
    }
}
