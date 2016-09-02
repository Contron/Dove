//
//  ControllerExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
	public func addChild(controller: UIViewController, view: UIView) {
		view.addSubview(controller.view)
		self.addChildViewController(controller)
	}
	
	public func addChild(controller: UIViewController) {
		self.addChild(controller, view: self.view)
	}
	
	public func removeChild() {
		self.view.removeFromSuperview()
		self.removeFromParentViewController()
	}
}

public extension UIApplication {
	public var topmostViewController: UIViewController? {
		var controller = self.keyWindow?.rootViewController
		
		while let next = controller?.presentedViewController {
			controller = next
		}
		
		return controller
	}
}
