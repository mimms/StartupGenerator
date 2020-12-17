//
//  URL.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 14.12.20.
//

import Foundation

extension URL {
    
    /**
     Convenience initializer which unwraps an url.
     - Parameters:
        - _:  a String containting the url.
     
     Usage: 
     ~~~
     let url = URL("https://yoururlstring.here")
     ~~~

    */
    init(_ string: String) {
        self.init(string: "\(string)")!
    }
}
