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
	public func addToParent(parent: UIViewController, view: UIView) {
		view.addSubview(self.view)
		parent.addChildViewController(self)
	}
	
	public func removeFromParent() {
		self.view.removeFromSuperview()
		self.removeFromParentViewController()
	}
}
