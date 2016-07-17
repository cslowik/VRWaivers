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
        phoneNumber.text = customer?.phoneNumber
        emailAddress.text = customer?.emailAddress
        
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
        Customer.current.firstName = (customer?.firstName)!
        Customer.current.lastName = (customer?.lastName)!
        Customer.current.phoneNumber = (customer?.phoneNumber)!
        Customer.current.emailAddress = (customer?.emailAddress)!
        
        NSNotificationCenter.defaultCenter().postNotificationName("checkedIn", object: nil)
    }

}
