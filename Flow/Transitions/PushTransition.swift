//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class PushTransition {

	weak var delegate: TransitionDelegate?

	private let navigationController: UINavigationController
	private let pushingViewController: UIViewController

	init(
		navigationController: UINavigationController,
		pushingViewController: UIViewController
	) {
		self.navigationController = navigationController
		self.pushingViewController = pushingViewController
	}

}

extension PushTransition: TransitionProtocol {
    
    func perform() {
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.delegate?.transitionDidFinish(self)
        }
        navigationController.pushViewController(pushingViewController, animated: true)
        CATransaction.commit()
    }
}
