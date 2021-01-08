//
//  IdeaInteractor.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation

// MARK: - Protocol
protocol IdeaBusinessLogic {
    func getNewIdea(request: Idea.Get.Request)
}

// MARK: - Class
class IdeaInteractor {
    var presenter: IdeaPresentationLogic?
    
    private func returnNewIdea(idea: String) {
        let response = Idea.Get.Response(text: idea)
        presenter?.presentIdea(response: response)
    }
}

// MARK: - Protocol Implementation
extension IdeaInteractor: IdeaBusinessLogic {
    
    internal func getNewIdea(request: Idea.Get.Request) {
        IdeaWorker.fetchIdea { [weak self] idea in
            self?.returnNewIdea(idea: idea)
        }
    }

}
