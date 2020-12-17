//
//  StartupIdeaViewModel.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 14.12.20.
//

import Foundation
import os.log

class StartupIdeaViewModel: ObservableObject {
        
    /// The startup idea expressed in words.
    @Published var ideaDescription: String = "So..." {
        willSet(newDescription) {
            os_log("Will show an idea. text=%@", log: OSLog.ui, type: .info, String(describing: newDescription))
        }
    }
    
    /// Fetches a new idea and updates StartupIdeaViewModel.ideaDescription when it's done.
    func fetchIdea() {
        
        // TODO: extract this functionality to a utils class.
        // Show special message during the time we are getting the new idea.
        // This method can be called from anywhere, so make sure we're on main thread before updating the UI
        if (Thread.isMainThread) {
            self.ideaDescription = "So..."
        } else {
            DispatchQueue.main.async {
                self.ideaDescription = "So..."
            }
        }
        
        // Show message long enough (at least 0.25s) so that the users can read it and then make the call.
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.25, execute: {
            
            // Call the webservice.
            Webservice.loadNewIdea() { [weak self] result in
                
                let textToPresent: String
                switch result {
                    case .success(var idea):
                        textToPresent = idea.description
                    case .failure(let error):
                        print(error.localizedDescription)
                        textToPresent = error.errorDescription ?? WebserviceError.unknownError
                }
                
                // Update UI on the main thread.
                DispatchQueue.main.async {
                    self?.ideaDescription = textToPresent
                }
            }
        })
        
    }

}
