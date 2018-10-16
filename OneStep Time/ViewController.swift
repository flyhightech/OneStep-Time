//
//  ViewController.swift
//  OneStep Time
//
//  Created by Bernard Huff on 10/4/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var goalTimePopupButton: NSPopUpButton!
    @IBOutlet weak var goalLabel: NSTextField!
    @IBOutlet weak var inOutButton: NSButton!
    @IBOutlet weak var currentlyLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var goalProgressIndicator: NSProgressIndicator!    
    @IBOutlet weak var remainingLabel: NSTextField!
    
    var currentPeriod:Period?
    var timer : Timer?
    var periods = [Period]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        goalTimePopupButton.removeAllItems()
        goalTimePopupButton.addItems(withTitles: titles())
        getPeriods()
        
    }
    
    func getPeriods() {
        
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let name = Period.entity().name {
                let fetchRequest = NSFetchRequest<Period>(entityName: name)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "outDate", ascending: false)]
                if var periods = try? context.fetch(fetchRequest) {
                    
                    for x in 0..<periods.count {
                        let period = periods[x]
                        if period.outDate == nil {
                            currentPeriod = period
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                                self.updateView()
                            })
                            periods.remove(at: x)
                            break
                        }
                    }
                    
                    self.periods = periods
                    
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
        
        remainingLabel.stringValue = remainingTimeAsString()
        
        let ratio = totalTimeInterval() / goalTimeInterval()
        goalProgressIndicator.doubleValue = ratio
        
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            for period in periods {
                context.delete(period)
            }
            
            if let currentPeriod = self.currentPeriod {
                context.delete(currentPeriod)
                self.currentPeriod = nil
            }
            getPeriods()
        }
        
    }
    
    func remainingTimeAsString() -> String {
        let remainingTime = goalTimeInterval() - totalTimeInterval()
        
        if remainingTime <= 0 {
            return "Finished! \(Period.stringFromDate(date1: Date(), date2: Date(timeIntervalSinceNow: totalTimeInterval())))"
        } else {
            return "Remaining \(Period.stringFromDate(date1: Date(), date2: Date(timeIntervalSinceNow: remainingTime)))"
        }
    }
    
    func totalTimeInterval() -> TimeInterval {
        
        var time = 0.0
        
        for period in periods {
            
            time += period.time()
        }
        
        if let currentPeriod = self.currentPeriod {
            
            time += currentPeriod.time()
            
        }
        
        return time
        
    }
    
    func goalTimeInterval() -> TimeInterval {
        return Double(goalTimePopupButton.indexOfSelectedItem + 1) * 60.0 * 60.0
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
            (NSApp.delegate as? AppDelegate)?.saveAction(nil)
            currentPeriod = nil
            timer?.invalidate()
            timer = nil
            getPeriods()
            
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
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return periods.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PeriodCell"), owner: self) as? PeriodCell
        
        let period = periods[row]
        
        cell?.timeTotalTextField.stringValue = Period.stringFromDate(date1: Date(), date2: Date(timeIntervalSinceNow: period.time()))
        cell?.timeRangeTextField.stringValue = "\(period.prettyInDate()) - \(period.prettyOutDate())"
        
        return cell
        
    }
    
    
    
}

class PeriodCell : NSTableCellView {
    
    @IBOutlet weak var timeRangeTextField: NSTextField!
    
    @IBOutlet weak var timeTotalTextField: NSTextField!
    
}

