//
//  BoilerPlateSUIApp.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 31/10/22.
//

import SwiftUI
import HyperSDK

@main
struct BoilerPlateSUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
