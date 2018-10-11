//
//  ViewController.swift
//  OneStep Time
//
//  Created by Bernard Huff on 10/4/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var goalTimePopupButton: NSPopUpButton!
    @IBOutlet weak var goalLabel: NSTextField!
    @IBOutlet weak var inOutButton: NSButton!
    @IBOutlet weak var currentlyLabel: NSTextField!
    
    var currentPeriod:Period?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTimePopupButton.removeAllItems()
        goalTimePopupButton.addItems(withTitles: titles())
        updateView()
    }
    
    func updateView() {
        let goalTime = goalTimePopupButton.indexOfSelectedItem + 1
        
        if goalTime == 1 {
            goalLabel.stringValue = "Goal: 1 Hour"
        } else {
            goalLabel.stringValue = "Goal: \(goalTime) Hours"
        }
    }
    
    @IBAction func inOutButtonPressed(_ sender: Any) {
        if currentPeriod == nil {
            if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
                currentPeriod = Period(context: context)
                currentPeriod?.inDate = Date()
                
            }
        }
        
        (NSApp.delegate as? AppDelegate)?.saveAction(nil)
        
    }
    
    @IBAction func goalTimePopupButtonPressed(_ sender: Any) {
        updateView()
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func titles() -> [String] {
        
        var titles = [String]()
        
        for number in 1...40 {
            titles.append("\(number)h")
        }
        
        return titles
        
    }
    
    
    
    
    
}
// Nothing below here

