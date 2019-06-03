//
//  ViewController.swift
//  GH
//
//  Created by Adam Reed on 12/9/18.
//  Copyright © 2018 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GoogleBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
    }
    
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
}


// TEST TEST TEST TEST
//ca-app-pub-3940256099942544/2934735716

// GOOGLE ADMOB AD UNIT ID
//ca-app-pub-4186253562269967/4588599313
