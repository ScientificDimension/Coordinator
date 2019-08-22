//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

final class AppCoordinatorBuilder {
    
    func build() -> AppCoordinator {
        let navigationController = UINavigationController()
        return AppCoordinator(
            rootNavigationInteractorBuilder: RootNavigationInteractorBuilder(navigationController: navigationController),
            coordinatorBuilder: CoordinatorBuilder(navigationController))
    }
}
