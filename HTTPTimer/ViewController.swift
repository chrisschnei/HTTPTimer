//
//  ViewController.swift
//  HTTPTimer
//
//  Created by Christian Schneider on 15.08.15.
//  Copyright (c) 2015 NonameCompany. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var HTTPUrlID: AnyObject = "" as AnyObject
    var TimeIntervalID: Double = 0.0
    var loopActive = false
    var iterations = 0
    var timer: Timer = Timer()
    
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var isActive: NSTextField!
    @IBOutlet weak var hostLabel: NSTextField!
    @IBOutlet weak var iterationsLabel: NSTextField!
    @IBOutlet weak var startedAtLabel: NSTextField!
    
    func loadConfigurationPlist() {
        let path = Bundle.main.path(forResource: "HTTPTimer", ofType: "plist")
        let myDict = NSDictionary(contentsOfFile: path!)
        if (myDict != nil) {
            self.HTTPUrlID = myDict!.value(forKey: "HTTPUrl")! as AnyObject
            self.TimeIntervalID = Double(truncating: myDict!.value(forKey: "TimeInterval")! as! NSNumber)
        } else {
            print("WARNING: Couldn't create dictionary from HTTPTimer.plist! Default values will be used!")
        }
    }
    
    @objc func sendHTTPRequest() {
        let url = URL(string: ("http://" + (self.HTTPUrlID as! String)))
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
        }) 
        task.resume()
        self.iterations += 1
        self.iterationsLabel.stringValue = String(self.iterations)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.isEnabled = false
        
        self.loadConfigurationPlist()
    }
    

    @IBAction func startSendingHTTPRequests(_ sender: AnyObject) {
        self.loadConfigurationPlist()
        self.hostLabel.stringValue = self.HTTPUrlID as! String
        self.iterationsLabel.stringValue = String(self.iterations)
        self.isActive.stringValue = "started"
        self.startButton.isEnabled = false
        self.stopButton.isEnabled = true
        
        let date = NSDate()
        let calendar = NSCalendar.current
        print(calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date as Date))
        let components = (calendar.dateComponents([.hour, .minute], from: date as Date))
        let hour = components.hour!
        let minutes = components.minute!
        self.startedAtLabel.stringValue = String(describing: hour) + ":" + String(describing: minutes)

        self.loopActive = true
        let seconds = self.TimeIntervalID*60.0
        self.timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(ViewController.sendHTTPRequest), userInfo: nil, repeats: true)
    }

    @IBAction func stopSendingHTTPRequests(_ sender: AnyObject) {
        self.startButton.isEnabled = true
        self.stopButton.isEnabled = false
        self.timer.invalidate()
        self.isActive.stringValue = "stopped"
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }

}

