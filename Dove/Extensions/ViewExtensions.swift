//
//  ViewExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 08/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
	func addShadow(radius: CGFloat, opacity: Float) {
		self.layer.shadowColor = UIColor.blackColor().CGColor
		self.layer.shadowOffset = CGSize()
		self.layer.shadowRadius = radius
		self.layer.shadowOpacity = opacity
	}
	
	@IBInspectable public var cornerRadius: CGFloat {
		get {
			return self.layer.cornerRadius
		}
		set {
			self.layer.cornerRadius = newValue
			self.layer.masksToBounds = newValue > 0
		}
	}
}
