//
//  ViewController.swift
//  Carousel
//
//  Created by Nattapong Unaregul on 7/22/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var carousel: Carolsel!
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.defaultImageName = "defaultImage.jpg"
        carousel.setUpImages(URLImages: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kzJ0rydH34OAftFVHOlKNkEywRfLw3qWgb_xRBk3GkDxq4CU"
        ,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShqJeLeyGvFqPxfdS36AMDPuZc1h2fqyr2gSPFCmm3DZALy0_oEg"
        ,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHyrrC0BdWFYOEXRmJv7EWoRiKoDYnmAjL3wq-XEBVMeYLXzQv4g"])
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

