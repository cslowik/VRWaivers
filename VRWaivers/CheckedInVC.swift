//
//  CheckedInVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class CheckedInVC: UIViewController {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var signature: UIImageView!
    @IBOutlet weak var operatorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operatorButton.addTarget(self, action: #selector(operatorMode), forControlEvents: .TouchUpInside)
        
        customerName.text = Customer.current.firstName + " " + Customer.current.lastName
        phoneNumber.text = Customer.current.phoneNumber
        emailAddress.text = Customer.current.emailAddress
        if let sig = Customer.current.signature {
            signature.image = UIImage(data: sig)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func operatorMode() {
        UIPasteboard.generalPasteboard().string = Customer.current.emailAddress
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
