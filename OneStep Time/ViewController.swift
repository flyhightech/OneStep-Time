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
    @IBOutlet weak var tableView: NSTableView!
    
    var currentPeriod:Period?
    var timer : Timer?
    var periods = [Period]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTimePopupButton.removeAllItems()
        goalTimePopupButton.addItems(withTitles: titles())
        getPeriods()
        
    }
    
    func getPeriods() {
        
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let name = Period.entity().name {
                let fetchRequest = NSFetchRequest<Period>(entityName: name)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "outDate", ascending: false)]
                if let periods = try? context.fetch(fetchRequest) {
                    self.periods = periods
                    for period in periods {
                        if period.outDate == nil {
                            currentPeriod = period
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                                self.updateView()
                            })
                        }
                    }
                }
            }
        }
        
        tableView.reloadData()
        updateView()
        
    }
    
    func updateView() {
        
        let goalTime = goalTimePopupButton.indexOfSelectedItem + 1
        
        if goalTime == 1 {
            goalLabel.stringValue = "Goal: 1 Hour"
        } else {
            goalLabel.stringValue = "Goal: \(goalTime) Hours"
        }
        
        if currentPeriod == nil {
            inOutButton.title = "In"
            currentlyLabel.isHidden = true
        } else {
            inOutButton.title = "Out"
            currentlyLabel.isHidden = false
            currentlyLabel.stringValue = "Currently: \(currentPeriod!.currentlyString())"
        }
        
    }
    
    @IBAction func inOutButtonPressed(_ sender: Any) {
        
//        Clocking in code below
        
        if currentPeriod == nil {
            if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
                currentPeriod = Period(context: context)
                currentPeriod?.inDate = Date()
                
            }
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.updateView()
            })
            
        } else {
            
//        Clocking out
            
            currentPeriod!.outDate = Date()
            currentPeriod = nil
            timer?.invalidate()
            timer = nil
            
        }
        
        updateView()
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

