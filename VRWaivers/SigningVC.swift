//
//  SigningVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit
import SnapKit

class SigningVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.addTarget(nil, action: Selector("completeTapped"), forControlEvents: .TouchUpInside)
        completeButton.addTarget(self, action: #selector(SigningVC.submitCustomer), forControlEvents: .TouchUpInside)
    }

    func submitCustomer() {
        print("submit")
    }
}
