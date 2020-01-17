//
//  TodayViewController.swift
//  KLGBreakingBadWidget
//
//  Created by Kevin Le Goff on 17/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import UIKit
import NotificationCenter
import KLBreakingBadAPI


class TodayViewController: UIViewController, NCWidgetProviding {

    let apiClient = BreakingBadRestApiClient()

    @IBOutlet var textLabel: UILabel!

    @IBOutlet var authorLabel: UILabel!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.startWaiting()
        apiClient.randomQuote {[weak self] response in
            DispatchQueue.main.async {
                self?.stopWaiting()
                if let err = response.error {
                    // We could probably come up with better UI than that in
                    // case a quote is already loaded instead and only show a warning to the user
                    self?.textLabel.text = err.localizedDescription
                    self?.authorLabel.text = ""
                    return
                }
                guard let quote = response.data else {
                    return
                }
                self?.displayQuote(quote)
            }
        }
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // We could have put the web service call here
        // but the  instruction mentionned "display random quote from a random character each time the widget is shown."
        // so the view Will appeared seemed more appropriate in that case as
        // as we update every time we are display the completion handler has never new data to show
        // that is the reason for the .noData
        completionHandler(.noData)
    }

    private func displayQuote(_ quote: Quote) {
        textLabel.text = quote.quote
        authorLabel.text = quote.author
    }

    private func startWaiting() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func stopWaiting() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

}
