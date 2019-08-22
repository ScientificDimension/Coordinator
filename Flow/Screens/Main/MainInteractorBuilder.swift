//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol InteractorBuilderProtocol {
	func build(coordinator: MainInteractorDelegate) -> MainInteractorProtocol
}

final class MainInteractorBuilder {

	private let navigationController: UINavigationController

	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainInteractorBuilder: InteractorBuilderProtocol {
  
    func build(coordinator: MainInteractorDelegate) -> MainInteractorProtocol {
        let viewController = MainViewController()
        let showTransition = PushTransition(
            navigationController: navigationController,
            pushingViewController: viewController)
        let hideTransition = PopTransition(
            navigationController: navigationController)
        let interactor = MainInteractor(
            viewController: viewController,
            showTransition: showTransition,
            hideTransition: hideTransition)
        
        interactor.delegate = coordinator
        viewController.delegate = interactor
        hideTransition.delegate = interactor
        
        return interactor
    }
}
