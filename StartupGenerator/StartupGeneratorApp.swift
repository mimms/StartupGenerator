//
//  StartupGeneratorApp.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 12.12.20.
//

import SwiftUI
import Sentry

@main
struct StartupGeneratorApp: App {
    init() {
        initializeSentry()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension StartupGeneratorApp {
    func initializeSentry() {
        SentrySDK.start { options in
                options.dsn = Constants.SentryAPIKey
                options.debug = true // Enabled debug when first installing is always helpful
            }
    }
}
