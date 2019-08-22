//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class DismissTransition {

	weak var delegate: TransitionDelegate?

	private let presenterViewController: UIViewController

	init(presenterViewController: UIViewController) {
		self.presenterViewController = presenterViewController
	}
}

extension DismissTransition: TransitionProtocol {
    
    func perform() {
        presenterViewController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.transitionDidFinish(self)
        }
    }
}
