//
//  DoneProtocol.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//

import UIKit
protocol DoneProtocol: class {
    func addDone(controller: AddBeastViewController, addedData mission: String)
    
    func editDone(controller: AddBeastViewController, editedData mission: String)
}
