//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class WindowTransition {
    
    let viewController: UIViewController
    let window: UIWindow
    
    init(
        viewController: UIViewController,
        window: UIWindow
    ) {
        self.viewController = viewController
        self.window = window
    }
}

extension WindowTransition: TransitionProtocol {
    
    func perform() {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
