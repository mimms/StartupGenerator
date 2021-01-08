//
//  IdeaController.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 07.01.21.
//

import Foundation
import os.log

// MARK: - Protocol
protocol IdeaDisplayLogic {
    func displayIdea(viewModel: Idea.Get.ViewModel)
}

// MARK: - Class
class IdeaViewController: ObservableObject {
    
    private var interactor: IdeaInteractor?
    
    internal init() {
        setupCleanArchitecture()
    }

    // Set up all components for Clean Architecture.
    private func setupCleanArchitecture() -> Void {
        let viewController = self
        let interactor = IdeaInteractor()
        let presenter = IdeaPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    /// The startup idea expressed in words. Use this published value to display in the view.
    @Published var ideaDescription: String = "So..." {
        willSet(newDescription) {
            os_log("Will show an idea. text=%@", log: OSLog.ui, type: .info, String(describing: newDescription))
        }
    }
    
    /// Requests new startup idea.
    internal func getNewIdea() -> Void {
        // Show special message during the time we are getting the new idea.
        // This method can be called from anywhere, so make sure to update the UI on the main thread.
        Execute.onMainThread({ self.ideaDescription = "So..." })
        
        // Show message long enough (at least 0.25s) so that the users can read it and then make the call.
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.25, execute: { [weak self] in
            let request = Idea.Get.Request()
            self?.interactor?.getNewIdea(request: request)
        })
    }
    
}

// MARK: - Protocol Implementation
extension IdeaViewController: IdeaDisplayLogic {
    
    internal func displayIdea(viewModel: Idea.Get.ViewModel) {
        // Show idea.
        // This method can be called from anywhere, so make sure to update the UI on the main thread.
        Execute.onMainThread({ self.ideaDescription = viewModel.text })
    }
}
