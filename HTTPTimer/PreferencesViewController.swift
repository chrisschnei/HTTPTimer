//
//  ViewController.swift
//  HTTPTimer
//
//  Created by Christian Schneider on 15.08.15.
//  Copyright (c) 2015 NonameCompany. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
    
    var test: ViewController = ViewController()
    @IBOutlet weak var IntervalText: NSPopUpButton!
    @IBOutlet weak var URLText: NSTextField!
    @IBOutlet weak var saveButton: NSButton!
    
    func loadConfigurationPlist() {
        let path = Bundle.main.path(forResource: "HTTPTimer", ofType: "plist")
        let myDict = NSDictionary(contentsOfFile: path!)
        if (myDict != nil) {
            self.URLText.stringValue = myDict!.value(forKey: "HTTPUrl")! as! String
            self.IntervalText.selectItem(withTitle: (myDict!.value(forKey: "TimeInterval")! as AnyObject).stringValue)
        } else {
            print("WARNING: Couldn't create dictionary from HTTPTimer.plist! Default values will be used!")
        }
    }
    
    @IBAction func saveConfiguration(_ sender: AnyObject) {
        //set data
        test.HTTPUrlID = URLText.stringValue as AnyObject
        test.TimeIntervalID = (self.IntervalText.selectedItem!.title as NSString).doubleValue
        let path = Bundle.main.path(forResource: "HTTPTimer", ofType: "plist")
        let dict: NSMutableDictionary = NSMutableDictionary()
        dict.setObject(test.HTTPUrlID, forKey: "HTTPUrl" as NSCopying)
        dict.setObject(test.TimeIntervalID, forKey: "TimeInterval" as NSCopying)
        dict.write(toFile: path!, atomically: true)
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        self.loadConfigurationPlist()
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
    
    
}

