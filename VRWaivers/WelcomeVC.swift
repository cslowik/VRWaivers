//
//  WelcomeVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet var numberPad: [UIButton]!
    var phoneNumber = "" {
        didSet {
            print(phoneNumber)
            if phoneNumber.characters.count < 4 {
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

        signInButton.layer.cornerRadius = 3
        signInButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        signInButton.layer.borderWidth = 1
        signInButton.layer.shadowRadius = 10
        signInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signInButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        signInButton.layer.shadowOpacity = 0.1
        signInButton.addTarget(nil, action: Selector("checkIn"), forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberTapped(sender: UIButton) {
        phoneNumber += String(sender.tag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
