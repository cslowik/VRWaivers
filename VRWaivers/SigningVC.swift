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
import Validator

class SigningVC: UIViewController {

    @IBOutlet weak var firstNameTextField: FloatLabelTextField!
    @IBOutlet weak var lastNameTextField: FloatLabelTextField!
    @IBOutlet weak var phoneNumberTextField: FloatLabelTextField!
    @IBOutlet weak var emailTextField: FloatLabelTextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var nameFields: UIView!
    @IBOutlet weak var contactFields: UIView!
    
    var keyboardConstant: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register for keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardNotification(_:)),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        
        completeButton.layer.cornerRadius = 3
        completeButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        completeButton.layer.borderWidth = 1
        completeButton.layer.shadowRadius = 10
        completeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        completeButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        completeButton.layer.shadowOpacity = 0.1
        completeButton.addTarget(self, action: #selector(SigningVC.submitCustomer), forControlEvents: .TouchUpInside)
        
        // layout stuff
        nameFields.snp_makeConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY)
            make.right.equalTo(view.snp_centerX).offset(-20)
        }
        
        contactFields.snp_makeConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY)
            make.left.equalTo(view.snp_centerX).offset(20)
        }
        
        completeButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_bottomMargin).offset(-20)
        }
        
    }

    func submitCustomer() {
        // validation
        let genericError = ValidationError(message: "error")
        let lengthRule = ValidationRuleLength(min: 2, failureError: genericError)
        let emailRule = ValidationRulePattern(pattern: .EmailAddress, failureError: genericError)
        var phoneRules = ValidationRuleSet<String>()
        let phoneLengthRule = ValidationRuleLength(min: 10, max: 10, failureError: genericError)
        let digitRule = ValidationRulePattern(pattern: .ContainsNumber, failureError: genericError)
        phoneRules.addRule(digitRule)
        phoneRules.addRule(phoneLengthRule)
        
        let firstNameResult = Validator.validate(input: firstNameTextField.text, rule: lengthRule)
        let lastNameResult = Validator.validate(input: lastNameTextField.text, rule: lengthRule)
        let phoneNumberResult = Validator.validate(input: phoneNumberTextField.text, rules: phoneRules)
        let emailAddressResult = Validator.validate(input: emailTextField.text, rule: emailRule)
        
        let results = firstNameResult.merge(lastNameResult.merge(phoneNumberResult.merge(emailAddressResult)))
        
        if results.isValid {
            firstNameTextField.toggleError(false)
            lastNameTextField.toggleError(false)
            phoneNumberTextField.toggleError(false)
            emailTextField.toggleError(false)
            
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
            
            Alamofire.request(.POST, "https://connect.squareup.com/v2/customers", headers: headers, parameters: params, encoding: .JSON)
                .responseJSON { response in
                    print(response.result.value)
            }
        } else {
            print("nicetry")
            // handle validation errors
            if !firstNameResult.isValid {
                // if the first name is invalid
                firstNameTextField.toggleError(true)
            }
            if !lastNameResult.isValid {
                // if the last name is invalid
                lastNameTextField.toggleError(true)
            }
            if !phoneNumberResult.isValid {
                // if the phone number is invalid
                phoneNumberTextField.toggleError(true)
            }
            if !emailAddressResult.isValid {
                // if the email is invalid
                emailTextField.toggleError(true)
            }
        }
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.keyboardConstant = 0.0
                self.updateViewConstraints()
            } else {
                self.keyboardConstant = ((view.frame.height - (endFrame?.size.height)!) / -2) - 40 ?? 0.0
                self.updateViewConstraints()
            }
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    override func updateViewConstraints() {
        nameFields.snp_updateConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY).offset(keyboardConstant)
        }
        contactFields.snp_updateConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY).offset(keyboardConstant)
        }
        if keyboardConstant == 0 {
            completeButton.snp_remakeConstraints { (make) in
                make.bottom.equalTo(view.snp_bottomMargin).offset(-20)
            }
        } else {
            completeButton.snp_remakeConstraints { (make) in
                make.bottom.equalTo(view.snp_centerY).offset(-40)
            }
        }
        
        super.updateViewConstraints()
    }
}
