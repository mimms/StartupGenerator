//
//  Execute.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation

struct Execute {
    /// Checks the current thread and dispatches the execution of code to the main thread if not already on it.
    static func onMainThread(_ code: @escaping() -> ()) {
        if (Thread.isMainThread) {
            code()
        } else {
            DispatchQueue.main.async {
                code()
            }
        }
    }
}
