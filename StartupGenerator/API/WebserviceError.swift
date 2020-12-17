//
//  WebserviceError.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 15.12.20.
//

import Foundation

/// Common errors which can occur when calling the Webservice
enum WebserviceError: Error {
    /// Unknown error
    case unknown
    /// The device has no internet connection
    case offline
    /// The server timed out
    case serverTimeout
    /// The server response failed to decode
    case couldNotDecode
}

extension WebserviceError: LocalizedError {
    
    /// Description of default error
    public static var unknownError: String {
        NSLocalizedString("Something went terribly wrong. Please contact the developer.", comment: "")
    }
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return WebserviceError.unknownError
        case .offline:
            return NSLocalizedString("I can't think without the Internet. Please connect me.", comment: "")
        case .serverTimeout:
            return NSLocalizedString("I can't reach the idea generator. Please try again later.", comment: "")
        case .couldNotDecode:
            return NSLocalizedString("This idea was bad. Please contact the developer.", comment: "")
        }
    }

}
