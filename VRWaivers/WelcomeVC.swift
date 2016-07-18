//
//  WelcomeVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit
import Validator
import RealmSwift
import PopupCollectionViewController
import UPCarouselFlowLayout

class WelcomeVC: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet var numberPad: [UIButton]!
    @IBOutlet weak var deleteButton: UIButton!
    
    var realm: Realm!
    var popupVC: PopupCollectionViewController!
    
    var phoneNumber = "" {
        didSet {
            if phoneNumber == "" {
                self.phoneNumberLabel.text = ""
            } else if phoneNumber.characters.count < 4 {
                self.phoneNumberLabel.text = "(" + phoneNumber.stringByPaddingToLength(3, withString: " ", startingAtIndex: 0) + ")"
            } else if phoneNumber.characters.count < 7 {
                self.phoneNumberLabel.text = "(" + phoneNumber.substringToIndex(phoneNumber.startIndex.advancedBy(3)) + ") " + phoneNumber.substringFromIndex(phoneNumber.startIndex.advancedBy(3))
            } else {
                self.phoneNumberLabel.text = "(" + phoneNumber.substringToIndex(phoneNumber.startIndex.advancedBy(3)) + ") " +
                    phoneNumber.substringWithRange(Range<String.Index>(phoneNumber.startIndex.advancedBy(3) ..< phoneNumber.startIndex.advancedBy(6))) + "-"
                    + phoneNumber.substringFromIndex(phoneNumber.startIndex.advancedBy(6))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dismissPopup), name: "checkedIn", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.newCustomerAndGo), name: "newCustomerAndGo", object: nil)
        
        signInButton.layer.cornerRadius = 3
        signInButton.layer.borderColor = UIColor(red:0.145,  green:0.506,  blue:0.098, alpha:1).CGColor
        signInButton.layer.borderWidth = 1
        signInButton.layer.shadowRadius = 10
        signInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signInButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        signInButton.layer.shadowOpacity = 0.1
        signInButton.addTarget(self, action: #selector(self.checkIn), forControlEvents: UIControlEvents.TouchUpInside)
        
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
    
    @IBAction func numberTapped(sender: UIButton) {
        if sender.tag == 99 {
            phoneNumber = phoneNumber.substringToIndex(phoneNumber.endIndex.advancedBy(-1))
        } else {
            if phoneNumber.characters.count < 10 {
                phoneNumber += String(sender.tag)
            }
        }
        
        if phoneNumber != "" {
            UIView.animateWithDuration(0.35, animations: { 
                self.deleteButton.alpha = 1
                self.signInButton.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.35, animations: { 
                self.deleteButton.alpha = 0
                self.signInButton.alpha = 0
            })
        }
    }
    
    func startOver() {
        print("test")
    }

    func newCustomer() {
        Customer.current = Customer()
    }
    
    func newCustomerAndGo() {
        newCustomer()
        Customer.current.phoneNumber = phoneNumber
        if (popupVC != nil) {
            popupVC.dismissViewController {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let waiverFlow: WaiverPageVC = storyboard.instantiateViewControllerWithIdentifier("pageViewController") as! WaiverPageVC
                self.navigationController?.pushViewController(waiverFlow, animated: true)
            }
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let waiverFlow: WaiverPageVC = storyboard.instantiateViewControllerWithIdentifier("pageViewController") as! WaiverPageVC
            self.navigationController?.pushViewController(waiverFlow, animated: true)
        }
    }
    
    func checkIn() {
        
        // validation
        var phoneRules = ValidationRuleSet<String>()
        let phoneLengthRule = ValidationRuleLength(min: 10, max: 10, failureError: ValidationError(message: "Not a full phone number"))
        let digitRule = ValidationRulePattern(pattern: .ContainsNumber, failureError: ValidationError(message: "Not a number"))
        phoneRules.addRule(digitRule)
        phoneRules.addRule(phoneLengthRule)
        let phoneNumberResult = Validator.validate(input: phoneNumber, rules: phoneRules)
        if phoneNumberResult.isValid {
            // if the phone number is valid, query db for customers
            let predicate = NSPredicate(format: "phoneNumber = %@", phoneNumber)
            let customers = realm.objects(Customer.self).filter(predicate)
            if customers.count == 0 {
                print("no customers found")
                
                // create customer if none found
                newCustomerAndGo()
                
            } else {
                
                popupVC = PopupCollectionViewController(fromVC: self.navigationController!)
                // if customers exist, show them as a card carousel, also a new button
                print(String(customers.count) + " customers found")
                var customerControllers: [UIViewController] = []
                for cust in customers {
                    let newVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("customerCard") as! CustomerCardVC
                    newVC.customer = cust
                    customerControllers.append(newVC)
                }
                popupVC.presentViewControllers(customerControllers,
                                               options: [.Layout(.Center),
                                                        .PopupHeight(360),
                                                        .CellWidth(480),
                                                        .OverlayColor(UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:0.85))],
                                               completion: nil)
            }
        }
    }
    
    func dismissPopup() {
        popupVC.dismissViewController { 
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let checkedInVC: CheckedInVC = storyboard.instantiateViewControllerWithIdentifier("checkedInVC") as! CheckedInVC
            self.presentViewController(checkedInVC, animated: true, completion: {
                //completion
            })
        }
    }

}
