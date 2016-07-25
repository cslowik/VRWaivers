//
//  SkewedCell.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/24/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit
import QuartzCore

class SkewedCell: UICollectionViewCell {
    
    //MARK:- Properties
    var image: UIImage?
    var text: String?
    
    // Views
    let imageView = UIImageView()
    let textLabel = UILabel()
    let gradient = CAGradientLayer()
    
    // Layout Variables
    var parallaxModifier: CGFloat = 0.5     // 0 to 1
    var cellSpacing: CGFloat = 2
}
