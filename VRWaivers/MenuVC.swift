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
    
    let images = [UIImage(named: "fruitNinja"),
                  UIImage(named: "jobSimulator"),
                  UIImage(named: "recRoom"),
                  UIImage(named: "spacePirateTrainer"),
                  UIImage(named: "vanishingRealms")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(closeMenu), forControlEvents: .TouchUpInside)
        scroller.delegate = self
        setup()
    }

    func setup() {
        scroller.frame = view.bounds
        print(scroller.frame)
        for (index, image) in images.enumerate() {
            let imageView = UIImageView(image: image)
            scroller.addSubview(imageView)
            imageView.frame = CGRectOffset(imageView.frame, 1024 * CGFloat(index), 0)
        }
        scroller.contentSize = CGSize(width: CGFloat(images.count * 1024), height: 728)
    }
    
    func closeMenu() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
