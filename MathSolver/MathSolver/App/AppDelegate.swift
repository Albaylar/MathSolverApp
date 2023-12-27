//
//  AppDelegate.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import NeonSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Font.configureFonts(font: .Poppins)
        
        AdaptyManager.configure(withAPIKey: "public_live_wdH6hiJh.ekwI5jlMJfzCNb9yLFX9", placementIDs: ["placement_2"])
        Neon.configure(
            window: &window,
            onboardingVC: Onboarding1VC(),
            paywallVC: PaywallVC(),
            homeVC: HomeVC())
        
        return true
    }
}

