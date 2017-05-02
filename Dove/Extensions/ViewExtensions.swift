//
//  ViewExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 08/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
	public func apply(filter: CIFilter, options: [String: Any]? = nil) -> UIImage? {
		guard let image = self.cgImage else {
			return nil
		}
		
		filter.setValue(CoreImage.CIImage(cgImage: image), forKey: kCIInputImageKey)
		
		if let options = options {
			for (option, value) in options {
				filter.setValue(value, forKey: option)
			}
		}
		
		if let output = filter.outputImage {
			if let output = context.createCGImage(output, from: output.extent) {
				return UIImage(cgImage: output, scale: self.scale, orientation: self.imageOrientation)
			}
		}
		
		return nil
	}
	
	public func isEqualData(image: UIImage) -> Bool {
		if let first = UIImagePNGRepresentation(self), let second = UIImagePNGRepresentation(image) {
			if first.count != second.count {
				return first == second
			} else {
				return true
			}
		}
		
		return false
	}
}

public extension UIColor {
	func adjust(amount: CGFloat) -> UIColor {
		var red = CGFloat(0)
		var green = CGFloat(0)
		var blue = CGFloat(0)
		
		var alpha = CGFloat(0)
		
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return UIColor(red: red + amount, green: green + amount, blue: blue + amount, alpha: alpha)
		}
		
		return self
	}
}

public extension UITableViewCell {
	public var selectedColour: UIColor? {
		get {
			return self.selectedBackgroundView?.backgroundColor
		}
		set {
			let view = UIView()
			view.backgroundColor = newValue
			
			self.selectedBackgroundView = view
		}
	}
}

public extension UICollectionViewCell {
	public var selectedColour: UIColor? {
		get {
			return self.selectedBackgroundView?.backgroundColor
		}
		set {
			let view = UIView()
			view.backgroundColor = newValue
			
			self.selectedBackgroundView = view
		}
	}
}

private let context = CIContext()
