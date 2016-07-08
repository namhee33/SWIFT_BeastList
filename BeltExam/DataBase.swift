//
//  DataBase.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//
import Foundation

class Database{
    static func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        return paths[0]
    }
    
    static func dataFilePath(schema: String) -> String {
        return "\(Database.documentsDirectory())/\(schema)"
    }
    
    static func save(arrayOfObjects: [AnyObject], toSchema: String, forKey: String){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(arrayOfObjects, forKey: "\(forKey)")
        archiver.finishEncoding()
        data.writeToFile(Database.dataFilePath(toSchema), atomically: true)
    }
}
