//
//  ImageExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 05/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

infix operator ≈≈: ComparisonPrecedence
infix operator !≈: ComparisonPrecedence

public extension UIImage {
	public static func ≈≈(first: UIImage, second: UIImage) -> Bool {
		guard let first = UIImagePNGRepresentation(first), let second = UIImagePNGRepresentation(second) else {
			return false
		}
		
		return first == second
	}
	
	public static func !≈(first: UIImage, second: UIImage) -> Bool {
		guard let first = UIImagePNGRepresentation(first), let second = UIImagePNGRepresentation(second) else {
			return false
		}
		
		return first != second
	}
	
	public static func generate(colour: UIColor) -> UIImage? {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		
		defer {
			UIGraphicsEndImageContext()
		}
		
		guard let context = UIGraphicsGetCurrentContext() else {
			return nil
		}
		
		context.setFillColor(colour.cgColor)
		context.fill(CGRect(origin: .zero, size: CGSize(width: 1, height: 1)))
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
	public func apply(filter: CIFilter, options: [String: Any]? = nil) -> UIImage? {
		guard let image = self.cgImage else {
			return nil
		}
		
		filter.setValue(CoreImage.CIImage(cgImage: image), forKey: kCIInputImageKey)
		options?.forEach({ filter.setValue($0.value, forKey: $0.key) })
		
		guard let output = filter.outputImage, let result = context.createCGImage(output, from: output.extent) else {
			return nil
		}
		
		return UIImage(cgImage: result, scale: self.scale, orientation: self.imageOrientation)
	}
	
	public func flip(to orientation: UIImageOrientation) -> UIImage? {
		guard let image = self.cgImage else {
			return nil
		}
		
		return UIImage(cgImage: image, scale: self.scale, orientation: orientation)
	}
	
	public func colourise(to colour: UIColor, mask: UIImage?) -> UIImage? {
		guard let image = self.cgImage else {
			return nil
		}
		
		UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
		
		defer {
			UIGraphicsEndImageContext()
		}
		
		guard let context = UIGraphicsGetCurrentContext() else {
			return nil
		}
		
		let frame = CGRect(origin: .zero, size: self.size)
		 
		context.translateBy(x: 0, y: self.size.height)
		
		context.scaleBy(x: 1, y: -1)
		context.setBlendMode(.normal)
		context.draw(image, in: frame)
		
		context.setBlendMode(.overlay)
		context.setFillColor(colour.cgColor)
		
		if let mask = mask?.cgImage {
			context.clip(to: frame, mask: mask)
		}
		
		context.fill(frame)
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}

private let context = CIContext()

public extension UIColor {
	public enum AdjustmentMode {
		case colour
		case alpha
		case hue
		case saturation
		case brightness
	}
	
	public convenience init(hex: Int, alpha: CGFloat = 1) {
		let red = CGFloat((hex >> 16) & 0xFF) / 255
		let green = CGFloat((hex >> 8) & 0xFF) / 255
		let blue = CGFloat((hex >> 0) & 0xFF) / 255
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	public func adjust(mode: AdjustmentMode, amount: CGFloat) -> UIColor {
		switch mode {
		case .colour, .alpha:
			var red = CGFloat(0)
			var green = CGFloat(0)
			var blue = CGFloat(0)
			var alpha = CGFloat(0)
			
			guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
				break
			}
			
			switch mode {
			case .colour:
				return UIColor(red: red + amount, green: green + amount, blue: blue + amount, alpha: alpha)
			case .alpha:
				return UIColor(red: red, green: green, blue: blue, alpha: alpha + amount)
			default:
				break
			}
		case .hue, .saturation, .brightness:
			var hue = CGFloat(0)
			var saturation = CGFloat(0)
			var brightness = CGFloat(0)
			var alpha = CGFloat(0)
			
			guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
				break
			}
			
			switch mode {
			case .hue:
				return UIColor(hue: hue + amount, saturation: saturation, brightness: brightness, alpha: alpha)
			case .saturation:
				return UIColor(hue: hue, saturation: saturation + amount, brightness: brightness, alpha: alpha)
			case .brightness:
				return UIColor(hue: hue, saturation: saturation, brightness: brightness + amount, alpha: alpha)
			default:
				break
			}
		}
		
		return self
	}
}
