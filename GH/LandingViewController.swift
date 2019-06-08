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
        
        // TEST TEST TEST TEST
        var testGoogleMob = "ca-app-pub-3940256099942544/2934735716"
        var realGoogleMob = "ca-app-pub-4186253562269967/4588599313"
        
        GoogleBannerView.adUnitID = testGoogleMob
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
    }
    
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
}
