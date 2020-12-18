//
//  Webservice.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 14.12.20.
//

import Foundation
import os.log
import Sentry

class Webservice {
    
    /**
     Makes an API call to get a new startup idea.
     
     - Parameter completion: Code to be executed when the call is done. It must be a closure that takes a Result of StartupIdea in case of success or a WebserviceError in case of failure.
     
     */
    
    static func loadNewIdea(completion:@escaping ( (Result<StartupIdea, WebserviceError>) -> Void )) {
        
        let url = URL(Constants.WebserviceAPIurl)
        
        os_log("Making API call... ", log: OSLog.networking, type: .debug)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                os_log("Couldn't get idea from API. url=%@, error=%@", log: OSLog.networking, type: .error, String(describing: url), String(describing: error))
                SentrySDK.capture(message: "API error. url=\(url) error=\(String(describing: error))")

                
                if let error = error as NSError? {
                    switch error.code {
                        case NSURLErrorNotConnectedToInternet:
                            completion(.failure(.offline))
                        case NSURLErrorTimedOut:
                            completion(.failure(.serverTimeout))
                        default:
                            completion(.failure(.unknown))
                    }
                }
                return
            }
            
            let response = try? JSONDecoder().decode(StartupIdea.self, from: data)
            os_log("API responded. response=%@", log: OSLog.networking, type: .debug, String(describing: response))
            
            if let response = response {
                completion(.success(response))
            } else {
                os_log("API response could not be decoded.", log: OSLog.networking, type: .error)
                SentrySDK.capture(message: "Decoding error for StartupIdea. data=\(data)")
                completion(.failure(.couldNotDecode))
            }
            
        }
        
        task.resume()
        
    }
}
