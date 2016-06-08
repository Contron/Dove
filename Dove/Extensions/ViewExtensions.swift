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
	@IBInspectable public var cornerRadius: CGFloat {
		get {
			return self.layer.cornerRadius
		}
		set {
			self.layer.cornerRadius = newValue
			self.layer.masksToBounds = newValue > 0
		}
	}
	
	@IBInspectable public var edgeAntiAliasing: Bool {
		get {
			return self.layer.allowsEdgeAntialiasing
		}
		set {
			self.layer.allowsEdgeAntialiasing = newValue
		}
	}
}
