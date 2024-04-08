//
//  UIImage+Merge.swift
//  ImageCompositingOverCamera
//
//  Created by 201510003 on 2020/06/01.
//  Copyright © 2020 Sunmin, Hong. All rights reserved.
//

import UIKit

extension UIImage {
    func merge(in rect: CGRect, topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: rect, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}
