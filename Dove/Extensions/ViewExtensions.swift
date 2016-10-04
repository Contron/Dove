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
				return UIImage(cgImage: output)
			}
		}
		
		return nil
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

private let context = CIContext(eaglContext: EAGLContext(api: .openGLES2), options: [kCIContextWorkingColorSpace: NSNull()])
