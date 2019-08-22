//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {

	func viewControllerUserDidTapBackButton(_: MainViewController)
	func viewControllerUserDidTapStartNextCoordinator(_: MainViewController)
}

final class MainViewController: UIViewController {

	weak var delegate: MainViewControllerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapStartNextCoordinator)))
	}

	@objc func userDidTapStartNextCoordinator() {
		delegate?.viewControllerUserDidTapStartNextCoordinator(self)
	}
}

extension MainViewController: DataUpdatable {

	func update(with data: Any) {
		//TODO: perform update
		print(data)
	}
}
