//
//  BeastedTableController.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//

import UIKit

class BeastedTableController: UITableViewController{
    var allBeasts = [Beast]()
    var bList = [Beast]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        allBeasts = Beast.all()
        findBeastedList()
        tableView.reloadData()
    }
    
    func findBeastedList(){
        bList = []
        for beast in allBeasts {
            if beast.beasted == "true" {
                bList.append(beast)
            }
        }
    }
    
    //1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bList.count
    }
    
    //2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        cell.textLabel?.text = bList[indexPath.row].objective
        
        cell.detailTextLabel?.text = convertDateToString(bList[indexPath.row].beastedAt)
        
        return cell
    }
    
    func convertDateToString(bDate: NSDate) -> String {
        let df = NSDateFormatter()
        df.dateFormat = "EEE MMM d"
        return df.stringFromDate(bDate)
    }
    
    // swiping to delete item
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        bList[indexPath.row].destroy()
        bList.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
}

