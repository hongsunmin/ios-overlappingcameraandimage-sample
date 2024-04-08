//
//  DecoratePhotoViewController.swift
//  ImageCompositingOverCamera
//
//  Created by 201510003 on 2020/05/20.
//  Copyright © 2020 Sunmin, Hong. All rights reserved.
//

import UIKit
import UIView_draggable

class DecoratePhotoViewController: UIViewController {
    
    var backgroundImage: UIImage? {
        get { return backgroundImageView.image }
        set { backgroundImageView.image = newValue }
    }

    @IBOutlet
    var backgroundImageView: UIImageView!
    
    @IBOutlet
    var targetView: UIView!
    
    @IBOutlet
    var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view1.enableDragging()
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
