//
//  ToBeastTableController.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//

import UIKit

class ToBeastTableController: UITableViewController, DoneProtocol, CancelProtocol{
    
    var inEditing = false
    var beasts = [Beast]()
    var allBeasts = [Beast]()
   
    
    
    @IBAction func addBtnPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("AddBeast", sender: self)
    }
    
    func findBeastList(){
        print("All Beasts List before find: ")
       
        for beast in allBeasts {
            print(beast.objective)
            if beast.beasted == "true"{
                print(beast.objective)
            }
        }
        beasts = []
        for beast in allBeasts {
            if beast.beasted == "false"{
                beasts.append(beast)
            }
        }
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddBeast" {
            let navController = segue.destinationViewController as! UINavigationController
            
            let controller = navController.topViewController as! AddBeastViewController
            controller.doneDelegate = self
            controller.cancelDelegate = self
            if inEditing {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                    controller.beastToEdit = beasts[indexPath.row]
                    print("send to edit: ", beasts[indexPath.row].objective)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allBeasts = Beast.all()
        findBeastList()
    }
    
    //1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }
  
    
    //2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell")! as! CustomCell
        cell.beastLabel.text = beasts[indexPath.row].objective
        
        cell.beastBtn.tag = indexPath.row
        
        cell.beastBtn.addTarget(self, action:Selector("goToBeast:"), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    // swiping to delete item
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        beasts[indexPath.row].destroy()
        beasts.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    //tab to edit item
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        inEditing = true
        performSegueWithIdentifier("AddBeast", sender: tableView.cellForRowAtIndexPath((indexPath)))
    }
    
    func goToBeast(sender: AnyObject){
        print("BeastIndex to beast: ", sender.tag)
        for beast in allBeasts {
            if beast.objective == beasts[sender.tag].objective {
                beast.beastedAt = NSDate()
                beast.beasted = "true"
                beast.save()
                print("beast is beasted! ", beast.objective, beast.beastedAt)
                break
            }
        }
        allBeasts = Beast.all()
        findBeastList()
        tableView.reloadData()
    }
    
    func cancelJob(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
        inEditing = false
    }
    
    func addDone(controller: AddBeastViewController, addedData mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        inEditing = false
        let newMission = Beast(obj: mission)
        newMission.save()
        print("add: ", newMission.objective)
        beasts.append(newMission)
       
        tableView.reloadData()
        
    }
    
    func editDone(controller: AddBeastViewController, editedData mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        inEditing = false
        controller.beastToEdit!.objective = mission
        controller.beastToEdit!.save()
        inEditing = false
        beasts[beasts.indexOf(controller.beastToEdit!)!].objective = mission
//        print("edit: ", books[books.indexOf(controller.bookToEdit!)!].title)
       
        tableView.reloadData()
    }

}
