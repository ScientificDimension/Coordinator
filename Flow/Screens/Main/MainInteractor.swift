//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

protocol MainInteractorProtocol: ShowTransitionPerformable, DataUpdatable, HideTransitionPerformable {
	var delegate: MainInteractorDelegate? { get set }
}

protocol MainInteractorDelegate: AnyObject {
	func interactorUserDidTapStartNextCoordinator(_: MainInteractorProtocol)
	func interactorUserDidTapBackButton(_: MainInteractorProtocol)
	func interactorDidFinishFlow(_: MainInteractorProtocol)
}

final class MainInteractor: MainInteractorProtocol {

	private let viewController: DataUpdatable
	private let showTransition: TransitionProtocol
	private let hideTransition: TransitionProtocol

	weak var delegate: MainInteractorDelegate?

	init(
		viewController: DataUpdatable,
		showTransition: TransitionProtocol,
		hideTransition: TransitionProtocol
	) {
		self.viewController = viewController
		self.showTransition = showTransition
		self.hideTransition = hideTransition
	}
}

extension MainInteractor: ShowTransitionPerformable {

	func performShowTransition() {
		showTransition.perform()
	}
}

extension MainInteractor: DataUpdatable {

	func update(with data: Any) {
		viewController.update(with: data)
	}
}

extension MainInteractor: HideTransitionPerformable {

	func performHideTransition() {
		hideTransition.perform()
	}
}

extension MainInteractor: MainViewControllerDelegate {

	func viewControllerUserDidTapBackButton(_: MainViewController) {
		delegate?.interactorUserDidTapBackButton(self)
	}

	func viewControllerUserDidTapStartNextCoordinator(_: MainViewController) {
		delegate?.interactorUserDidTapStartNextCoordinator(self)
	}
}

extension MainInteractor: TransitionDelegate {

	func transitionDidFinish(_ transition: TransitionProtocol) {
		if transition === hideTransition {
			delegate?.interactorDidFinishFlow(self)
		}
	}
}
