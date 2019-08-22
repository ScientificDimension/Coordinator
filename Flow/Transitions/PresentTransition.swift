//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class PresentTransition {

	weak var delegate: TransitionDelegate?

	private let presenterViewController: UIViewController
	private let presentingViewController: UIViewController

	init(
		presenterViewController: UIViewController,
		presentingViewController: UIViewController
	) {
		self.presenterViewController = presenterViewController
		self.presentingViewController = presentingViewController
	}
}

extension PresentTransition: TransitionProtocol {
   
    func perform() {
        presenterViewController.present(presentingViewController, animated: false) { [weak self] in
            guard let self = self else { return }
            self.delegate?.transitionDidFinish(self)
        }
    }

}
