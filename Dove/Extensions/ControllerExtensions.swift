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
	public static func topmost(controller: UIViewController?) -> UIViewController? {
		if let controller = controller as? UINavigationController, let visible = controller.visibleViewController {
			return UIViewController.topmost(controller: visible)
		}
		
		if let controller = controller as? UITabBarController, let selected = controller.selectedViewController {
			return UIViewController.topmost(controller: selected)
		}
		
		if let controller = controller?.presentedViewController {
			return UIViewController.topmost(controller: controller)
		}
		
		return controller
	}
	
	public func addChild(controller: UIViewController, view: UIView) {
		view.addSubview(controller.view)
		self.addChildViewController(controller)
		controller.didMove(toParentViewController: self)
	}
	
	public func addChild(controller: UIViewController) {
		self.addChild(controller: controller, view: self.view)
	}
	
	public func removeChild() {
		self.willMove(toParentViewController: nil)
		self.view.removeFromSuperview()
		self.removeFromParentViewController()
	}
	
	public func showAlert(title: String, message: String, block: ActionBlock? = nil) {
		let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		controller.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
			block?()
		}))
		
		self.present(controller, animated: true, completion: nil)
	}
}

public extension UIApplication {
	public var topmostController: UIViewController? {
		return UIViewController.topmost(controller: self.keyWindow?.rootViewController)
	}
}
