//
//  ViewController.swift
//  OneStep Time
//
//  Created by Bernard Huff on 10/4/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//
//  Test 1

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var goalTimePopupButton: NSPopUpButton!
    
    @IBOutlet weak var goalLabel: NSTextField!
    
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

