//
//  HTTPTimerTests.swift
//  HTTPTimerTests
//
//  Created by Christian Schneider on 15.08.15.
//  Copyright (c) 2015 NonameCompany. All rights reserved.
//

import XCTest
@testable import HTTPTimer

class HTTPTimerTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: Bundle.main)
        vc = (storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController")) as? ViewController)!
        _ = vc.view
        vc.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfigurationLoading()
    {
        vc.loadConfigurationPlist()
        
        /* URL should never be empty. */
        if ((vc.HTTPUrlID as! String).isEmpty) {
            XCTAssert(false)
            return
        }
        
        /* Sending packages to url should not be started. */
        if (vc.loopActive) {
            XCTAssert(false)
            return
        }
        
        /* Program is just started so iterations should be 0. */
        if (vc.iterations != 0) {
            XCTAssert(false)
            return
        }
        
        /* Only numbers are valid. */
        if (vc.TimeIntervalID.isNaN) {
            XCTAssert(false)
            return
        }
        
        XCTAssert(true)
    }
    
}
