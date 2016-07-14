//
//  WaiverPageVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class WaiverPageVC: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("waiverVC"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("signingVC"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("signatureVC")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}