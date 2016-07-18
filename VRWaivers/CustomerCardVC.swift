//
//  CustomerCardVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class CustomerCardVC: UIViewController {
    
    var customer: Customer?
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 6.0
        
        customerName.text = (customer?.firstName)! + " " + (customer?.lastName)!
        emailAddress.text = customer?.emailAddress
        
        if let phoneNum = customer?.phoneNumber {
            phoneNumber.text = "(" + phoneNum.substringToIndex(phoneNum.startIndex.advancedBy(3)) + ") " +
                phoneNum.substringWithRange(Range<String.Index>(phoneNum.startIndex.advancedBy(3) ..< phoneNum.startIndex.advancedBy(6))) + "-"
                + phoneNum.substringFromIndex(phoneNum.startIndex.advancedBy(6))
        }
        
        selectButton.layer.cornerRadius = 3
        selectButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        selectButton.layer.borderWidth = 1
        selectButton.layer.shadowRadius = 10
        selectButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        selectButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        selectButton.layer.shadowOpacity = 0.1
        selectButton.addTarget(nil, action: #selector(self.checkIn), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func checkIn() {
        // set current customer
        Customer.current = customer!
        NSNotificationCenter.defaultCenter().postNotificationName("checkedIn", object: nil)
    }

}
