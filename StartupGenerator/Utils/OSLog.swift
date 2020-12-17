//
//  OSLog.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 14.12.20.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "com.example"

    /// Log networking activity, like URLSession tasks.
    static let networking = OSLog(subsystem: subsystem, category: "networking")
    /// Log UI activity, like when something is being displayed to the user.
    static let ui = OSLog(subsystem: subsystem, category: "ui")
}
