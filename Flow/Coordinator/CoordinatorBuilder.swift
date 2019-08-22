//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol CoordinatorBuilderProtocol {
	func build(delegate: CoordinatorDelegate, someData: Any) -> Coordinator
}

final class CoordinatorBuilder: CoordinatorBuilderProtocol {

	private let entryPoint: UINavigationController

	init(_ entryPoint: UINavigationController) {
		self.entryPoint = entryPoint
	}

	func build(delegate: CoordinatorDelegate, someData: Any) -> Coordinator {
		let cooridnator = Coordinator(
			mainScreenInteractorBuilder: MainInteractorBuilder(entryPoint),
			loaderScreenInteractorBuilder: LoaderInteractorBuilder(entryPoint, someData),
			nextFlowCoordinatorBuilder: CoordinatorBuilder(entryPoint))
		cooridnator.delegate = delegate
		return cooridnator
	}
}
