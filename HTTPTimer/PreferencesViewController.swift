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
        let path = NSBundle.mainBundle().pathForResource("HTTPTimer", ofType: "plist")
        let myDict = NSDictionary(contentsOfFile: path!)
        if (myDict != nil) {
            self.URLText.stringValue = myDict!.valueForKey("HTTPUrl")! as! String
            self.IntervalText.selectItemWithTitle(myDict!.valueForKey("TimeInterval")!.stringValue)
        } else {
            print("WARNING: Couldn't create dictionary from HTTPTimer.plist! Default values will be used!")
        }
    }
    
    @IBAction func saveConfiguration(sender: AnyObject) {
        //set data
        test.HTTPUrlID = URLText.stringValue
        test.TimeIntervalID = (self.IntervalText.selectedItem!.title as NSString).doubleValue
        let path = NSBundle.mainBundle().pathForResource("HTTPTimer", ofType: "plist")
        let dict: NSMutableDictionary = NSMutableDictionary()
        dict.setObject(test.HTTPUrlID, forKey: "HTTPUrl")
        dict.setObject(test.TimeIntervalID, forKey: "TimeInterval")
        dict.writeToFile(path!, atomically: true)
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

