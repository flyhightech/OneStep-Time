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

    }
    
    @IBAction func goalTimePopupButtonPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    
    
    
    
    
}
// Nothing below here

