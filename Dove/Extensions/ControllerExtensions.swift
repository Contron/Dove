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
	public static func topmost(viewController: UIViewController) -> UIViewController? {
		if let controller = viewController as? UINavigationController, let visible = controller.visibleViewController {
			return UIViewController.topmost(viewController: visible)
		}
		
		if let controller = viewController as? UITabBarController, let selected = controller.selectedViewController {
			return UIViewController.topmost(viewController: selected)
		}
		
		if let controller = viewController.presentedViewController {
			return UIViewController.topmost(viewController: controller)
		}
		
		return viewController
	}
}

public extension UIApplication {
	public var topmostViewController: UIViewController? {
		guard let controller = self.keyWindow?.rootViewController else {
			return nil
		}
		
		return UIViewController.topmost(viewController: controller)
	}
}
