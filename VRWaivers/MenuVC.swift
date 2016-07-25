//
//  MenuVC.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/24/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scroller: UIScrollView!
    
    let images = [UIImage(named: "audioshield"),
                  UIImage(named: "blu"),
                  UIImage(named: "holopoint"),
                  UIImage(named: "irrationalExuberance"),
                  UIImage(named: "spacePirateTrainer")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroller.delegate = self
        setup()
    }

    func setup() {
        scroller.frame = view.bounds
        print(scroller.frame)
        scroller.bounces = false
        scroller.alwaysBounceHorizontal = true
        for (index, image) in images.enumerate() {
            let imageView = UIImageView(image: image)
            scroller.addSubview(imageView)
            imageView.frame = CGRectOffset(imageView.frame, 1024 * CGFloat(index), 0)
        }
        scroller.contentSize = CGSize(width: CGFloat(images.count * 1024), height: scroller.frame.height)
    }
}
