//
//  CameraViewController.swift
//  ImageCompositingOverCamera
//
//  Created by 201510003 on 2020/05/20.
//  Copyright © 2020 Sunmin, Hong. All rights reserved.
//

import UIKit
import SwiftyCam
import AVFoundation

class CameraViewController: SwiftyCamViewController {
    
    @IBOutlet
    var view1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.audioEnabled = false
        self.cameraDelegate = self
        self.pinchToZoom = false
        self.swipeToZoom = false
        self.tapToFocus = false
        
        view1.enableDragging()
        view1.enableZooming()
    }
    
    // MARK: - Private
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "imgFocus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Action
    
    @IBAction
    func takePhoto(_ sender: UIButton) {
        takePhoto()
    }
    
    @IBAction
    func switchCamera(_ sender: UIButton) {
        switchCamera()
    }
    
    @IBAction
    func zoomScaleChanged(_ sender: UISlider) {
        do {
            let captureDevice = AVCaptureDevice.devices().first
            try captureDevice?.lockForConfiguration()

            let zoomScale = min(maxZoomScale, max(1.0, min(CGFloat(sender.value) ,  captureDevice!.activeFormat.videoMaxZoomFactor)))

            captureDevice?.videoZoomFactor = zoomScale

            captureDevice?.unlockForConfiguration()

        } catch {
            print("[SwiftyCam]: Error locking configuration")
        }
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let _ = sender else {
            return false
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let decoratePhotoController = segue.destination as? DecoratePhotoViewController {
            decoratePhotoController.loadViewIfNeeded()
            decoratePhotoController.backgroundImage = sender as? UIImage
        } else if let decorateResultController = segue.destination as? DecorateResultViewController {
            decorateResultController.image = sender as? UIImage
        }
    }
    
    @IBAction
    func unwindToCameraController(_ unwindSegue: UIStoryboardSegue) {
        let _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}

extension CameraViewController: SwiftyCamViewControllerDelegate {
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
//        performSegue(withIdentifier: "decoratePhotoSegue", sender: photo)
        
        let xScale = photo.size.width / view.frame.size.width
        let yScale = photo.size.height / view.frame.size.height
        var rect: CGRect = .zero
        rect.origin.x = view1.frame.origin.x * xScale
        rect.origin.y = view1.frame.origin.y * yScale
        rect.size = view1.frame.size
        rect.size.width *= xScale
        rect.size.height *= yScale
        let newImage = photo.merge(in: rect, topImage: view1.image!)
        
        performSegue(withIdentifier: "decorateResultSegue", sender: newImage)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        focusAnimationAt(point)
    }
}
