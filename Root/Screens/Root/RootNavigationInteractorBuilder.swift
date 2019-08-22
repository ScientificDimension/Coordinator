//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

protocol RootNavigationInteractorBuilderProtocol {
    func build() -> RootNavigationInteractorProtocol
}

final class RootNavigationInteractorBuilder {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension RootNavigationInteractorBuilder: RootNavigationInteractorBuilderProtocol {
    
    func build() -> RootNavigationInteractorProtocol {
        return RootNavigationInteractor(
            showTransition: WindowTransition(
                viewController: navigationController,
                window: UIWindow()))
    }
}
