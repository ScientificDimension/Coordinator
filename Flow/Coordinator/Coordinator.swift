//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

protocol CoordinatorDelegate: AnyObject {
	func coordinatorDidFinishFlow(_: Coordinator)
}

final class Coordinator {

	weak var delegate: CoordinatorDelegate?

	let mainScreenInteractorBuilder: InteractorBuilderProtocol
	var mainScreenInteractor: (ShowTransitionPerformable & DataUpdatable & HideTransitionPerformable)?

	let loaderScreenInteractorBuilder: LoaderInteractorBuilderProtocol
	var loaderScreenInteractor: (ShowTransitionPerformable & PreviousResponseErasable)?

	private let nextFlowCoordinatorBuilder: CoordinatorBuilderProtocol
	private var nextFlowCoordinator: ShowTransitionPerformable?

	init(
		mainScreenInteractorBuilder: InteractorBuilderProtocol,
		loaderScreenInteractorBuilder: LoaderInteractorBuilderProtocol,
		nextFlowCoordinatorBuilder: CoordinatorBuilderProtocol
	) {
		self.mainScreenInteractorBuilder = mainScreenInteractorBuilder
		self.loaderScreenInteractorBuilder = loaderScreenInteractorBuilder
		self.nextFlowCoordinatorBuilder = nextFlowCoordinatorBuilder
	}
}

extension Coordinator: ShowTransitionPerformable {

	func performShowTransition() {
		mainScreenInteractor = mainScreenInteractorBuilder.build(coordinator: self)
		mainScreenInteractor?.performShowTransition()
		loaderScreenInteractor = loaderScreenInteractorBuilder.build(coordinator: self)
		loaderScreenInteractor?.performShowTransition()
	}
}

extension Coordinator: MainInteractorDelegate {

	func interactorUserDidTapStartNextCoordinator(_: MainInteractorProtocol) {
		nextFlowCoordinator = nextFlowCoordinatorBuilder.build(delegate: self, someData: "any")
		nextFlowCoordinator?.performShowTransition()
	}

	func interactorUserDidTapBackButton(_: MainInteractorProtocol) {
		mainScreenInteractor?.performHideTransition()
	}

	func interactorDidFinishFlow(_: MainInteractorProtocol) {
		delegate?.coordinatorDidFinishFlow(self)
	}
}

extension Coordinator: CoordinatorDelegate {

	func coordinatorDidFinishFlow(_: Coordinator) {
		nextFlowCoordinator = nil
	}
}

extension Coordinator: LoaderInteractorDelegate {

	func interactor(_: LoaderInteractorProtocol, requestDidSuccess data: Any) {
		mainScreenInteractor?.update(with: data)
	}

	func interactor(_: LoaderInteractorProtocol, requestDidFailure error: Error) {
		// TODO: perform
//		errorScreenInteractor = errorScreenInteractorBuilder.build(coordinator: self, error: error)
//		errorScreenInteractor?.performShowTransition()
	}

	func interactorUserDidCancelRequest(_: LoaderInteractorProtocol) {
		mainScreenInteractor?.performHideTransition()
	}
}
