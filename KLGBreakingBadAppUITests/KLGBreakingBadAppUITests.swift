//
//  KLGBreakingBadAppUITests.swift
//  KLGBreakingBadAppUITests
//
//  Created by Kevin Le Goff on 15/01/2020.
//  Copyright © 2020 tdl. All rights reserved.
//

import XCTest

class KLGBreakingBadAppUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    override func tearDown() {}
    
    func testCharcaterListScreenComponents() {
        let app = XCUIApplication()
        app.launch()
        // Check the screen title
        let breakingBadNavigationBar = app.navigationBars["Breaking Bad"]
        XCTAssert(breakingBadNavigationBar.exists)
        let randomButton =  app.navigationBars["Breaking Bad"]/*@START_MENU_TOKEN@*/.buttons["but_random_quote "]/*[[".buttons[\"Random Quote\"]",".buttons[\"but_random_quote \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(randomButton.exists)
        // Check the table view is here
        let charTable = XCUIApplication().tables["table_characters"]
        XCTAssert(charTable.exists)
    }
    
    func testFromListToRandomQuoteAndBack() {
        let app = XCUIApplication()
        app.launch()
        // Go to the Quote screen
        let randomButton =  app.navigationBars["Breaking Bad"]/*@START_MENU_TOKEN@*/.buttons["but_random_quote "]/*[[".buttons[\"Random Quote\"]",".buttons[\"but_random_quote \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        randomButton.tap()
        
        // Check we are on the quotes screen
        let quotesNavigationBar = app.navigationBars["Quotes"]
        XCTAssert(quotesNavigationBar.otherElements["Quotes"].exists)
        
        // Check the two to display the quote and its author labels are here
        waitElementToExist(app/*@START_MENU_TOKEN@*/.staticTexts["label_quote_main_text"]/*[[".staticTexts[\"Stay out of my territory.\"]",".staticTexts[\"label_quote_main_text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
        waitElementToExist(app/*@START_MENU_TOKEN@*/.staticTexts["label_quote_main_author"]/*[[".staticTexts[\"Walter White\"]",".staticTexts[\"label_quote_main_author\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
        
        // Click on Back
        quotesNavigationBar.buttons["Breaking Bad"].tap()
        // Check we are back to the character list screen
        XCTAssert(app.navigationBars["Breaking Bad"].otherElements["Breaking Bad"].exists)
    }
    
    func testFromListToRandomQuoteViaCharacter() {
        let app = XCUIApplication()
        app.launch()
        let walterWhiteTableRow = app.tables["table_characters"]/*@START_MENU_TOKEN@*/.staticTexts["Walter White"]/*[[".cells.staticTexts[\"Walter White\"]",".staticTexts[\"Walter White\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        waitElementToExist(walterWhiteTableRow)
        walterWhiteTableRow.tap()
        // Check we are on the quote screen
        XCTAssert(app.navigationBars["Quotes"].exists)
        // Check the label with Walter get populated within 10 second
        waitElementToExist(app.staticTexts["Walter White"])
        // Check the existence of the share button
        waitElementToExist(app.navigationBars["Quotes"].buttons["Share"])
        
    }
    
    func waitElementToExist(_ elementA: XCUIElement, timeout: TimeInterval = 10.0) {
        let startTime = Date.timeIntervalSinceReferenceDate
        while (!elementA.exists) {
            if (NSDate.timeIntervalSinceReferenceDate - startTime > timeout) {
                XCTFail("Timed out waiting for either element to exist.")
                break
            }
            sleep(1)
        }
    }
}
