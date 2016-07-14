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
        
        agreeButton.addTarget(nil, action: "agreeTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

