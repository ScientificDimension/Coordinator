//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol LoaderInteractorBuilderProtocol {
	func build(coordinator: LoaderInteractorDelegate) -> LoaderInteractorProtocol
}

final class LoaderInteractorBuilder {

	private let navigationController: UINavigationController
	private let someData: Any

	init(
		_ navigationControoler: UINavigationController,
		_ someData: Any
	) {
		self.navigationController = navigationControoler
		self.someData = someData
	}
}

extension LoaderInteractorBuilder: LoaderInteractorBuilderProtocol {
   
    func build(coordinator: LoaderInteractorDelegate) -> LoaderInteractorProtocol {
        let viewController = LoaderViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        let dismissTransition = DismissTransition(
            presenterViewController: navigationController)
        let showTransition = PresentTransition(
            presenterViewController: navigationController,
            presentingViewController: viewController)
        let interactor = LoaderInteractor(
            showTransition: showTransition,
            hideTransition: dismissTransition,
            someData: someData)
        dismissTransition.delegate = interactor
        showTransition.delegate = interactor
        interactor.delegate = coordinator
        viewController.delegate = interactor
        
        return interactor
    }
}
