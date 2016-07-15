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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
