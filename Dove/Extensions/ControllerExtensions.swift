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
		self.addChild(controller: controller, view: self.view)
	}
	
	public func removeChild() {
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
	public var topmostViewController: UIViewController? {
		var controller = self.keyWindow?.rootViewController
		
		while let next = controller?.presentedViewController {
			controller = next
		}
		
		return controller
	}
}
