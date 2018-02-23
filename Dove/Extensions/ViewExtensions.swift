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
	public func render() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
		
		defer {
			UIGraphicsEndImageContext()
		}
		
		self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}

public extension UITableViewCell {
	public var selectedColour: UIColor? {
		get {
			return self.selectedBackgroundView?.backgroundColor
		}
		set {
			self.selectedBackgroundView = UIView(colour: newValue)
		}
	}
}

public extension UICollectionViewCell {
	public var selectedColour: UIColor? {
		get {
			return self.selectedBackgroundView?.backgroundColor
		}
		set {
			self.selectedBackgroundView = UIView(colour: newValue)
		}
	}
}

public extension UITraitCollection {
	public var sizeClasses: (horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass) {
		return (self.horizontalSizeClass, self.verticalSizeClass)
	}
}

private extension UIView {
	convenience init(colour: UIColor?) {
		self.init()
		
		self.backgroundColor = colour
	}
}
