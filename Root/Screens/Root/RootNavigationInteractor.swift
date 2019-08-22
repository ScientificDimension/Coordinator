//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

protocol RootNavigationInteractorProtocol: ShowTransitionPerformable {}

final class RootNavigationInteractor: RootNavigationInteractorProtocol {
    
    private let showTransition: TransitionProtocol
    
    init(showTransition: TransitionProtocol) {
        self.showTransition = showTransition
    }
}

extension RootNavigationInteractor: ShowTransitionPerformable {
    
    func performShowTransition() {
        showTransition.perform()
    }
}
