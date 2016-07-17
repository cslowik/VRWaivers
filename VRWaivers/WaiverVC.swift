//
//  WaiverVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class WaiverVC: UIViewController {

    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        agreeButton.layer.cornerRadius = 3
        agreeButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        agreeButton.layer.borderWidth = 1
        agreeButton.layer.shadowRadius = 10
        agreeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        agreeButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        agreeButton.layer.shadowOpacity = 0.1
        agreeButton.addTarget(nil, action: Selector("agreeTapped"), forControlEvents: UIControlEvents.TouchUpInside)
    }
}

