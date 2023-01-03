//
//  PVRedactorApp.swift
//  PVRedactor
//
//  Created by Serhii Kopytchuk on 27.12.2022.
//

import SwiftUI
import FirebaseCore

@main
struct PVRedactorApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
