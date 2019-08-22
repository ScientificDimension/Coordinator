//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 22/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator = AppCoordinatorBuilder().build()
        appCoordinator?.performShowTransition()

        return true
	}
}

