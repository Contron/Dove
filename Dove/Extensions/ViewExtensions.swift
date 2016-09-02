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
	public func applyFilter(filter: String) -> UIImage? {
		guard let inputImage = self.CGImage else {
			return nil
		}
		
		guard let filter = CIFilter(name: filter) else {
			return nil
		}
		
		let inputCoreImage = CoreImage.CIImage(CGImage: inputImage)
		
		filter.setValue(inputCoreImage, forKey: kCIInputImageKey)
		
		if let outputCoreImage = filter.outputImage {
			let outputImage = context.createCGImage(outputCoreImage, fromRect: outputCoreImage.extent)
			let output = UIImage(CGImage: outputImage)
			
			return output
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

private let context = CIContext()
