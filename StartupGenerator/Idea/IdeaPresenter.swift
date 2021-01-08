//
//  IdeaPresenter.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation

// MARK: - Protocol
protocol IdeaPresentationLogic {
    func presentIdea(response: Idea.Get.Response)
}

// MARK: - IdeaPresenter
class IdeaPresenter: IdeaPresentationLogic {
    weak var viewController: IdeaViewController?
    
    func presentIdea(response: Idea.Get.Response) {
        // Translate between the Interactor and the Controller.
        // In this case, this step seems a bit excessive since it's just one String value, but it is good practice.
        let viewModel = Idea.Get.ViewModel(text: response.text)
        viewController?.displayIdea(viewModel: viewModel)
    }
}
