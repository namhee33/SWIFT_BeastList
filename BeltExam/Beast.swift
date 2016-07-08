//
//  Beast.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//
import UIKit

class Beast: NSObject, NSCoding {
    static var key: String = "Missions"
    static var schema: String = "BeltExam"
    
    var objective: String
    var createdAt: NSDate
    var beastedAt: NSDate
    var beasted: String
    
    init(obj: String){
        objective = obj
        createdAt = NSDate()
        beastedAt = NSDate()
        beasted = "false"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
        aCoder.encodeObject(beastedAt, forKey: "beastedAt")
        aCoder.encodeObject(beasted, forKey: "beasted")
        
       
    }
    
    required init?(coder aDecoder: NSCoder){
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        beastedAt = aDecoder.decodeObjectForKey("beastedAt") as! NSDate
        beasted = aDecoder.decodeObjectForKey("beasted") as! String
        
        super.init()
    }
    
    static func all() -> [Beast]{
        var missions = [Beast]()
        let path = Database.dataFilePath("BeltExam")
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                missions = unarchiver.decodeObjectForKey(Beast.key) as! [Beast]
                unarchiver.finishDecoding()
            }
        }
        return missions
    }
    
    func save(){
        var missionsFromStorage = Beast.all()
        var exists = false
        for var i=0;i<missionsFromStorage.count; ++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage[i] = self
                exists = true
            }
        }
        
        if !exists {
            missionsFromStorage.append(self)
        }
        Database.save(missionsFromStorage, toSchema: Beast.schema, forKey: Beast.key)
    }
    
    func destroy(){
        var missionsFromStorage = Beast.all()
        for var i=0;i<missionsFromStorage.count;++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(missionsFromStorage, toSchema: Beast.schema, forKey: Beast.key)
    }
    
}
