//
//  ViewController.swift
//  HTTPTimer
//
//  Created by Christian Schneider on 15.08.15.
//  Copyright (c) 2015 NonameCompany. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var HTTPUrlID: AnyObject = ""
    var TimeIntervalID: Double = 0.0
    var loopActive = false
    var iterations = 0
    var timer: NSTimer = NSTimer()
    
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var isActive: NSTextField!
    @IBOutlet weak var hostLabel: NSTextField!
    @IBOutlet weak var iterationsLabel: NSTextField!
    @IBOutlet weak var startedAtLabel: NSTextField!
    //Todo make singleton class so only one time read required.
    func loadConfigurationPlist() {
        let path = NSBundle.mainBundle().pathForResource("HTTPTimer", ofType: "plist")
        let myDict = NSDictionary(contentsOfFile: path!)
        if (myDict != nil) {
            self.HTTPUrlID = myDict!.valueForKey("HTTPUrl")!
            self.TimeIntervalID = Double(myDict!.valueForKey("TimeInterval")! as! NSNumber)
        } else {
            print("WARNING: Couldn't create dictionary from HTTPTimer.plist! Default values will be used!")
        }
    }
    
    func sendHTTPRequest() {
        let url = NSURL(string: ("http://" + (self.HTTPUrlID as! String)))
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        self.iterations++
        self.iterationsLabel.stringValue = String(self.iterations)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.enabled = false
        //Load Plist Settings
        self.loadConfigurationPlist()
    }
    

    @IBAction func startSendingHTTPRequests(sender: AnyObject) {
        self.loadConfigurationPlist()
        self.hostLabel.stringValue = self.HTTPUrlID as! String
        self.iterationsLabel.stringValue = String(self.iterations)
        self.isActive.stringValue = "started"
        self.startButton.enabled = false
        self.stopButton.enabled = true
        //Get Time
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        self.startedAtLabel.stringValue = String(hour) + ":" + String(minutes)

        self.loopActive = true
        let seconds = self.TimeIntervalID*60.0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: Selector("sendHTTPRequest"), userInfo: nil, repeats: true)
    }

    @IBAction func stopSendingHTTPRequests(sender: AnyObject) {
        self.startButton.enabled = true
        self.stopButton.enabled = false
        self.timer.invalidate()
        self.isActive.stringValue = "stopped"
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }

}

