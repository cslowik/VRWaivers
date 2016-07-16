//
//  LoginPopup.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class LoginPopup: UIView {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    override init(frame: CGRect) {
        playButton.layer.cornerRadius = 3
        playButton.layer.borderColor = UIColor(red:0.126,  green:0.510,  blue:0.066, alpha:1).CGColor
        playButton.layer.borderWidth = 1
        playButton.layer.shadowRadius = 10
        playButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        playButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        playButton.layer.shadowOpacity = 0.1
        playButton.addTarget(nil, action: #selector(self.playVR), forControlEvents: UIControlEvents.TouchUpInside)
        newButton.layer.cornerRadius = 3
        newButton.layer.borderColor = UIColor(red:0.118,  green:0.439,  blue:0.600, alpha:1).CGColor
        newButton.layer.borderWidth = 1
        newButton.layer.shadowRadius = 10
        newButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        newButton.layer.shadowColor = UIColor(red:0.133,  green:0.152,  blue:0.182, alpha:1).CGColor
        newButton.layer.shadowOpacity = 0.1
        newButton.addTarget(nil, action: #selector(self.newCustomer), forControlEvents: UIControlEvents.TouchUpInside)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newCustomer() {
        
    }
    
    func playVR() {
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
