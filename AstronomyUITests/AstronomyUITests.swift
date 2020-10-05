//
//  AstronomyUITests.swift
//  AstronomyUITests
//
//  Created by Craig Belinfante on 9/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy


class AstronomyUITests: XCTestCase {
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
     //   let app = XCUIApplication()
        let verticalScrollBar3PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar3PagesCollectionView.tap()
        verticalScrollBar3PagesCollectionView.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save to Photo Library"]/*[[".buttons[\"Save to Photo Library\"].staticTexts[\"Save to Photo Library\"]",".buttons[\"PhotoDetailViewController.SaveButton\"].staticTexts[\"Save to Photo Library\"]",".staticTexts[\"Save to Photo Library\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["“Astronomy” Would Like to Access Your Photos"].scrollViews.otherElements.buttons["Allow Access to All Photos"].tap()
        
        let backButton = app.navigationBars["Title"].buttons["Back"]
        backButton.tap()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element
        element.swipeUp()
        backButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 4).children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let element2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 6).children(matching: .other).element
        element2.swipeUp()
        element2.swipeUp()
        element.swipeDown()
        backButton.tap()
        element.swipeDown()
        
        
    }
}
