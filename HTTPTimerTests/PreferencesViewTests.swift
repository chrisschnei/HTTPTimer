//
//  PreferencesViewTests.swift
//  HTTPTimerTests
//
//  Created by Christian Schneider on 12.10.19.
//  Copyright © 2019 NonameCompany. All rights reserved.
//

import XCTest
@testable import HTTPTimer

class PreferencesViewTests: XCTestCase {

    var vc: PreferencesViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: Bundle.main)
        vc = (storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PreferencesViewController")) as? PreferencesViewController)!
        _ = vc.view
        vc.viewDidLoad()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDataNilUI()
    {
        let url = vc.URLText.stringValue
        let interval = vc.IntervalText.selectedItem!.title
        
        if (interval.isEmpty || url.isEmpty) {
            XCTAssert(false)
            return
        }
        
        XCTAssert(true)
    }

}
