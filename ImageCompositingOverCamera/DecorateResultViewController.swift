//
//  DecorateResultViewController.swift
//  ImageCompositingOverCamera
//
//  Created by 201510003 on 2020/06/01.
//  Copyright © 2020 Sunmin, Hong. All rights reserved.
//

import UIKit

class DecorateResultViewController: UIViewController {
    
    var image: UIImage?

    @IBOutlet
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
