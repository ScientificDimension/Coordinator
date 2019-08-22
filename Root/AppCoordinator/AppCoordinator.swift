//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

final class AppCoordinator {
    
    let rootNavigationInteractorBuilder: RootNavigationInteractorBuilderProtocol
    var rootNavigationInteractor: ShowTransitionPerformable?
    
    let coordinatorBuilder: CoordinatorBuilderProtocol
    var coordinator: ShowTransitionPerformable?
    
    init(
        rootNavigationInteractorBuilder: RootNavigationInteractorBuilderProtocol,
        coordinatorBuilder: CoordinatorBuilderProtocol
    ) {
        self.rootNavigationInteractorBuilder = rootNavigationInteractorBuilder
        self.coordinatorBuilder = coordinatorBuilder
    }
}

extension AppCoordinator: ShowTransitionPerformable {
    
    func performShowTransition() {
        rootNavigationInteractor = rootNavigationInteractorBuilder.build()
        rootNavigationInteractor?.performShowTransition()
        coordinator = coordinatorBuilder.build(delegate: self, someData: "someRequestId")
        coordinator?.performShowTransition()
    }
}

extension AppCoordinator: CoordinatorDelegate {
    
    func coordinatorDidFinishFlow(_: Coordinator) {
        coordinator = nil
    }
}
