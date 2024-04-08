//
//  UIVIew+Zoomable.swift
//  ImageCompositingOverCamera
//
//  Created by 201510003 on 2020/06/02.
//  Copyright © 2020 Sunmin, Hong. All rights reserved.
//

import UIKit

extension UIView {
    func enableZooming() {
        let pinch = gestureRecognizers?.filter({ (gestureRecognizer) -> Bool in
            if gestureRecognizer is UIPinchGestureRecognizer, gestureRecognizer.name == "ZoomablePinchGestureRecognizer" {
                return true
            }
            return false
        })
        guard pinch != nil else { return }
        
        let newPinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinchZoom))
        newPinch.name = "ZoomablePinchGestureRecognizer"
        addGestureRecognizer(newPinch)
        let newTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        newTap.numberOfTapsRequired = 2
        addGestureRecognizer(newTap)
    }
}

private extension UIView {
    @objc
    func didPinchZoom(_ pinch: UIPinchGestureRecognizer) {
        guard let view = pinch.view else { return }
        if pinch.state == .changed {
            let currentScale = view.frame.size.width / view.bounds.size.width
            var newScale = currentScale * pinch.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                view.transform = transform
                pinch.scale = 1
            } else {
                let transform = view.transform.scaledBy(x: pinch.scale, y: pinch.scale)
                view.transform = transform
                pinch.scale = 1
            }
        }
    }
    
    @objc
    func doubleTapped(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        view.transform = .identity
    }
}
