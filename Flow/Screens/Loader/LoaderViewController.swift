//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol LoaderViewControllerDelegate: AnyObject {
	func viewControllerUserDidCancelRequest(_: LoaderViewController)
}

final class LoaderViewController: UIViewController {

	/// UI
	private lazy var backgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 0, green: 0, blue: 20/255, alpha: 0.04)//UIColor.gray.withAlphaComponent(0.5)
		view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(view)
		NSLayoutConstraint.activate([
			self.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			self.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			self.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			self.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
		])
		return view
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .whiteLarge)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.color = .gray
		indicator.startAnimating()
		backgroundView.addSubview(indicator)
		NSLayoutConstraint.activate([
			indicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
			indicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
		])
		return indicator
	}()

	weak var delegate: LoaderViewControllerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		_ = backgroundView
		_ = activityIndicator
	}
}
