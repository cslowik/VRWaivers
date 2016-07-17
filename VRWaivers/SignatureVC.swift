//
//  SignatureVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit
import RealmSwift

class SignatureVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signatureView: SignatureView!
    @IBOutlet weak var saveButton: UIButton!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 3
        saveButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.shadowRadius = 10
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        saveButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        saveButton.layer.shadowOpacity = 0.1
        saveButton.addTarget(self, action: #selector(saveSignature), forControlEvents: .TouchUpInside)
        saveButton.addTarget(nil, action: #selector(WaiverPageVC.saveTapped), forControlEvents: .TouchUpInside)
        
        cancelButton.addTarget(nil, action: #selector(WaiverPageVC.startOver), forControlEvents: .TouchUpInside)
        
        do {
            realm = try Realm()
        } catch let error as NSError {
            // handle error
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func saveSignature() {
        if signatureView.containsSignature {
            // convert signature to data
            // save signature to db
            try! realm.write {
                Customer.current.signature = UIImagePNGRepresentation(signatureView.getSignature()!)
            }
            
        }
        
        // notify pageviewcontroller of tap
    }

}
