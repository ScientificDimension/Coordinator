//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class PopTransition {

	weak var delegate: TransitionDelegate?

	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension PopTransition: TransitionProtocol {
    
    func perform() {
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.delegate?.transitionDidFinish(self)
        }
        navigationController.popViewController(animated: true)
        CATransaction.commit()
    }
}
