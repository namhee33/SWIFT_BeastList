//
//  AddBeastViewController.swift
//  BeltExam
//
//  Created by namhee kim on 1/22/16.
//  Copyright © 2016 namhee kim. All rights reserved.
//

import UIKit

class AddBeastViewController: UIViewController{
    
    weak var doneDelegate: DoneProtocol?
    weak var cancelDelegate: CancelProtocol?
    var inEditing = false
    
    var beastToEdit: Beast?
    
    
    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        cancelDelegate?.cancelJob(self)
    }
    
    
    @IBAction func doneBtnPressed(sender: UIBarButtonItem) {
        if inEditing {
            doneDelegate?.editDone(self, editedData: beastTextField.text!)
        }else{
            doneDelegate?.addDone(self, addedData: beastTextField.text!)
        }
    }
    
    @IBOutlet weak var beastTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialB = beastToEdit {
            beastTextField.text = initialB.objective
            inEditing = true
        }
    }
    
}
