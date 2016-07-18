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
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("signatureVC"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("checkedInVC")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(completeTapped), name: "completeTapped", object: nil)
        
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
    
    func startOver() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func agreeTapped() {
        let nextViewController = orderedViewControllers[1]
        setViewControllers([nextViewController],
                           direction: .Forward,
                           animated: true,
                           completion: nil)
    }
    
    func completeTapped() {
        let nextViewController = orderedViewControllers[2]
        setViewControllers([nextViewController],
                           direction: .Forward,
                           animated: true,
                           completion: nil)
    }
    
    func saveTapped() {
        let nextViewController = orderedViewControllers[3]
        setViewControllers([nextViewController],
                           direction: .Forward,
                           animated: true,
                           completion: nil)
    }
}
