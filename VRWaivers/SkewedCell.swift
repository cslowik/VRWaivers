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
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        backgroundColor = UIColor.clearColor()
        
        imageView.frame = CGRectInset(bounds, 0, frame.height / 3)
        imageView.backgroundColor = UIColor.clearColor()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.mask = CAShapeLayer(layer: layer)
        
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offset: CGFloat = frame.origin.y - (superview as! UICollectionView).contentOffset.y
        parallaxModifier = offset/(superview?.frame.height)!
        imageView.frame = CGRectInset(bounds, 0, -bounds.height / 3)
        gradient.frame = imageView.bounds
    }
}
