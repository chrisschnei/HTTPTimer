//
//  HTTPTimerUITests.swift
//  HTTPTimerUITests
//
//  Created by Christian Schneider on 17.10.19.
//  Copyright © 2019 NonameCompany. All rights reserved.
//

import XCTest

class HTTPTimerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testPackagesendingStartStop() {
        let httptimerWindow = XCUIApplication().windows["HTTPTimer"]
        
        /* Start sending packages */
        httptimerWindow.buttons["Start"].click()
        XCTAssertFalse(httptimerWindow.buttons["startButton"].isEnabled)
        XCTAssertTrue(httptimerWindow.buttons["stopButton"].isEnabled)
        XCTAssertEqual(httptimerWindow.staticTexts["statusTextField"].value! as! String, "started")
        
        /* Ensure UI gets updated. */
        XCTAssertNotNil(httptimerWindow.staticTexts["headingText"].value as! String)
        XCTAssertEqual(httptimerWindow.staticTexts["sentRequestsTextField"].value as! String, "0")
        XCTAssertNotNil(httptimerWindow.staticTexts["hostTextField"].value as! String)
        
        /* Stop sending packages. */
        httptimerWindow.buttons["Stop"].click()
        XCTAssertTrue(httptimerWindow.buttons["startButton"].isEnabled)
        XCTAssertFalse(httptimerWindow.buttons["stopButton"].isEnabled)
        XCTAssertEqual(httptimerWindow.staticTexts["statusTextField"].value! as! String, "stopped")
    }
    
    func testPreferencesWindow() {
        let app = XCUIApplication()
        let menuBarsQuery = app.menuBars
        menuBarsQuery.menuBarItems["HTTPTimer"].click()
        menuBarsQuery/*@START_MENU_TOKEN@*/.menuItems["Preferences…"]/*[[".menuBarItems[\"HTTPTimer\"]",".menus.menuItems[\"Preferences…\"]",".menuItems[\"Preferences…\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.click()
        
        let preferencesDialog = app.dialogs["Preferences"]
        XCTAssertTrue(preferencesDialog.exists)
        preferencesDialog.children(matching: .textField).element.click()
        
        let popUpButton = preferencesDialog.children(matching: .popUpButton).element
        popUpButton.click()
        app/*@START_MENU_TOKEN@*/.menuItems["1"]/*[[".dialogs[\"Preferences\"]",".popUpButtons",".menus.menuItems[\"1\"]",".menuItems[\"1\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.click()
        
        XCTAssertEqual(app.popUpButtons["intervalPreferences"].value! as! String, "1")
        
        popUpButton.click()
        app/*@START_MENU_TOKEN@*/.menuItems["5"]/*[[".dialogs[\"Preferences\"]",".popUpButtons",".menus.menuItems[\"5\"]",".menuItems[\"5\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.click()
        
        XCTAssertEqual(app.popUpButtons["intervalPreferences"].value! as! String, "5")
        
        popUpButton.click()
        app/*@START_MENU_TOKEN@*/.menuItems["30"]/*[[".dialogs[\"Preferences\"]",".popUpButtons",".menus.menuItems[\"30\"]",".menuItems[\"30\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.click()
        
        XCTAssertEqual(app.popUpButtons["intervalPreferences"].value! as! String, "30")
        
        popUpButton.click()
        app/*@START_MENU_TOKEN@*/.menuItems["15"]/*[[".dialogs[\"Preferences\"]",".popUpButtons",".menus.menuItems[\"15\"]",".menuItems[\"15\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.click()
        
        XCTAssertEqual(app.popUpButtons["intervalPreferences"].value! as! String, "15")
        
        app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".dialogs[\"Preferences\"].buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
        XCTAssertFalse(preferencesDialog.exists)
    }

}
