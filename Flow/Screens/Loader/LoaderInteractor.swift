//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import Foundation

protocol LoaderInteractorProtocol: ShowTransitionPerformable, PreviousResponseErasable {
	var delegate: LoaderInteractorDelegate? { get set }
}

protocol PreviousResponseErasable {
	func erasePreviousResponse()
}

protocol LoaderInteractorDelegate: AnyObject {

	func interactor(_: LoaderInteractorProtocol, requestDidSuccess data: Any)
	func interactor(_: LoaderInteractorProtocol, requestDidFailure error: Error)
	func interactorUserDidCancelRequest(_: LoaderInteractorProtocol)
}

final class LoaderInteractor: LoaderInteractorProtocol {

	private let showTransition: TransitionProtocol
	private let hideTransition: TransitionProtocol
	private let someData: Any

	weak var delegate: LoaderInteractorDelegate?

	init(
		showTransition: TransitionProtocol,
		hideTransition: TransitionProtocol,
		someData: Any
	) {
		self.showTransition = showTransition
		self.hideTransition = hideTransition
		self.someData = someData
	}

	private var response: Result<Any, Error>?
}

extension LoaderInteractor: ShowTransitionPerformable {

	func performShowTransition() {
		showTransition.perform()
	}
}

extension LoaderInteractor: PreviousResponseErasable {

	func erasePreviousResponse() {
		response = nil
	}
}

extension LoaderInteractor: LoaderViewControllerDelegate {

	func viewControllerUserDidCancelRequest(_: LoaderViewController) {
		//TODO: cancel request
		erasePreviousResponse()
		hideTransition.perform()
	}
}

extension LoaderInteractor: TransitionDelegate {

	func transitionDidFinish(_ transition: TransitionProtocol) {
		if transition === showTransition {
			performRequest(someData: someData) { [weak self] response in
				guard let self = self else { return }
				self.response = response
				self.hideTransition.perform()
			}
		} else if transition === hideTransition {
			if let response = response {
				switch response {
				case let .success(data):
					delegate?.interactor(self, requestDidSuccess: data)
				case let .failure(error):
					delegate?.interactor(self, requestDidFailure: error)
				}
			} else {
				delegate?.interactorUserDidCancelRequest(self)
			}
		}
	}
}

private extension LoaderInteractor {

	func performRequest(someData: Any, completion: @escaping (Result<Any, Error>)->Void) {
		// TODO use someData to perform request
		DispatchQueue.main.async {
			completion(.success("Updated"))
		}
	}
}
