//
//  IdeaWorker.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation

// MARK: - Struct
struct IdeaWorker {
    
    /// Fetches a new idea from the webservice.
    static func fetchIdea(with callback: @escaping (String) -> Void) {
        // Call the webservice.
        Webservice.loadNewIdea() { result in
            
            let textToPresent: String
            switch result {
                case .success(var idea):
                    textToPresent = idea.description
                case .failure(let error):
                    print(error.localizedDescription)
                    textToPresent = error.errorDescription ?? WebserviceError.unknownError
            }
            callback(textToPresent)
        }
    }
    
}
