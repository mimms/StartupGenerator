//
//  StartupIdea.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 12.12.20.
//

import Foundation

/// Contains the startup idea as received from the webseervice..
struct WebserviceIdea: Decodable {
    private let this: String
    private let that: String
    
    lazy var description = {
        return "It's like \(this) for \(that)."
    }()
}
