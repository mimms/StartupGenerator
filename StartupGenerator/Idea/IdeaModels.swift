//
//  IdeaModels.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation

enum Idea {
    
    /// Command used to generate a new idea.
    enum Get {
        /// Request a new idea from the Interactor.
        struct Request {
            // request has no parameters
        }
        
        /// Response of the Interactor containing a new idea.
        struct Response {
            let text: String
        }
        
        /// ViewModel for displaying to the UI.
        struct ViewModel {
            let text: String
        }
    }
}
