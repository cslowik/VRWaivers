//
//  SigningVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

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
    @IBOutlet weak var nameFields: UIView!
    @IBOutlet weak var contactFields: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.layer.cornerRadius = 3
        completeButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        completeButton.layer.borderWidth = 1
        completeButton.layer.shadowRadius = 10
        completeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        completeButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        completeButton.layer.shadowOpacity = 0.1
        completeButton.addTarget(nil, action: Selector("completeTapped"), forControlEvents: .TouchUpInside)
        completeButton.addTarget(self, action: #selector(SigningVC.submitCustomer), forControlEvents: .TouchUpInside)
    }

    func submitCustomer() {
        let headers: [String: String] = [
            "Authorization": "Bearer sq0atp-rIBIuulvxZxX3JWh2wr91w",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let params: [String: AnyObject] = [
            "given_name": firstNameTextField.text!,
            "family_name": lastNameTextField.text!,
            "phone_number": phoneNumberTextField.text!,
            "email_address": emailTextField.text!
        ]
        print(params)
        Alamofire.request(.POST, "https://connect.squareup.com/v2/customers", headers: headers, parameters: params, encoding: .JSON)
            .responseJSON { response in
                print(response)
        }
    }
}
