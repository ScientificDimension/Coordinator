//
//  Coordinator
//
//  Created by Oleg Kolomyitsev on 23/08/2019.
//  Copyright © 2019 coordinator. All rights reserved.
//

protocol TransitionProtocol: AnyObject {
	func perform()
}

protocol TransitionDelegate: AnyObject {
	func transitionDidFinish(_: TransitionProtocol)
}
