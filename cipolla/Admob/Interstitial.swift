import SwiftUI
import GoogleMobileAds

class InterstitialAdManager: NSObject, ObservableObject {
    
    private struct AdMobConstant {
        static let interstitialID = "ca-app-pub-4186253562269967/1366323143"
        static let testInterstitialID = "ca-app-pub-3940256099942544/4411468910"
    }
    
    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {

        private var interstitial: GADInterstitialAd?
        
        override init() {
            super.init()
            requestInterstitialAds()
        }

        func requestInterstitialAds() {
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            GADInterstitialAd.load(withAdUnitID: AdMobConstant.testInterstitialID, request: request, completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                interstitial = ad
                interstitial?.fullScreenContentDelegate = self
            })
            
        }
        func showAd() {
            let root = UIApplication.shared.windows.last?.rootViewController
            if let fullScreenAds = interstitial {
                fullScreenAds.present(fromRootViewController: root!)
            } else {
                print("not ready to show interstitial ad")
            }
        }
    }
}


class AdsViewModel: ObservableObject {
    static let shared = AdsViewModel()
    @Published var interstitial = InterstitialAdManager.Interstitial()
    
    @Published var interstitialCounter = 0 {
        didSet {
            if interstitialCounter >= 5 {
                showInterstitial = true
                interstitialCounter = 0
            }
        }
    }
    
    
    @Published var showInterstitial = false {
        didSet {
            if showInterstitial {
                interstitial.showAd()
                showInterstitial = false
            } else {
                interstitial.requestInterstitialAds()
            }
        }
    }
}
