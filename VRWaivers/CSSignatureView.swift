//
//  CSSignatureView.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/13/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class CSSignatureView: UIView {
    // Properties
    var strokeColor:    UIColor!
    var hasSignature:   Bool!
    var sigImage:       UIImage!
    
    // Signature Point
    struct SignaturePoint {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func addVertex(length: UInt, vertex: SignaturePoint) {

    }
}
