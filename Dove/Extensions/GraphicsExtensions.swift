//
//  GraphicsExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 13/06/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

infix operator ≈≈: ComparisonPrecedence
infix operator !≈: ComparisonPrecedence

public extension CGPoint {
	public static func ≈≈(first: CGPoint, second: CGPoint) -> Bool {
		return Int(first.x) == Int(second.x) && Int(first.y) == Int(second.y)
	}
	
	public static func !≈(first: CGPoint, second: CGPoint) -> Bool {
		return Int(first.x) != Int(second.x) || Int(first.y) != Int(second.y)
	}
	
	public static func +(first: CGPoint, second: CGPoint) -> CGPoint {
		return CGPoint(x: first.x + second.x, y: first.y + second.y)
	}
	
	public static func -(first: CGPoint, second: CGPoint) -> CGPoint {
		return CGPoint(x: first.x - second.x, y: first.y - second.y)
	}
	
	public static func *(first: CGPoint, second: CGPoint) -> CGPoint {
		return CGPoint(x: first.x * second.x, y: first.y * second.y)
	}
	
	public static func /(first: CGPoint, second: CGPoint) -> CGPoint {
		return CGPoint(x: first.x / second.x, y: first.y / second.y)
	}
	
	public static func +(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x + value, y: point.y + value)
	}
	
	public static func -(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x - value, y: point.y - value)
	}
	
	public static func *(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x * value, y: point.y * value)
	}
	
	public static func /(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x / value, y: point.y / value)
	}
}

public extension CGSize {
	public static func ≈≈(first: CGSize, second: CGSize) -> Bool {
		return Int(first.width) == Int(second.width) && Int(first.height) == Int(second.height)
	}
	
	public static func !≈(first: CGSize, second: CGSize) -> Bool {
		return Int(first.width) != Int(second.width) || Int(first.height) != Int(second.height)
	}
	
	public static func +(first: CGSize, second: CGSize) -> CGSize {
		return CGSize(width: first.width + second.width, height: first.height + second.height)
	}
	
	public static func -(first: CGSize, second: CGSize) -> CGSize {
		return CGSize(width: first.width - second.width, height: first.height - second.height)
	}
	
	public static func *(first: CGSize, second: CGSize) -> CGSize {
		return CGSize(width: first.width * second.width, height: first.height * second.height)
	}
	
	public static func /(first: CGSize, second: CGSize) -> CGSize {
		return CGSize(width: first.width / second.width, height: first.height / second.height)
	}
	
	public static func +(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width + value, height: size.height + value)
	}
	
	public static func -(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width - value, height: size.height - value)
	}
	
	public static func *(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width * value, height: size.height * value)
	}
	
	public static func /(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width / value, height: size.height / value)
	}
}

public enum ResizeMode {
	case fit
	case fill
}

public extension CGRect {
	public func resize(to mode: ResizeMode, inside rect: CGRect) -> CGRect {
		let size = self.size.resize(to: mode, inside: rect.size)
		let origin = CGPoint(x: (self.size.width - size.width) / 2, y: (self.size.height - size.height) / 2)
		
		return CGRect(origin: origin, size: size)
	}
	
	func fitting(to rect: CGRect, padding: CGFloat) -> CGRect {
		let x = max(min(self.origin.x, (rect.size.width - self.size.width) - padding), rect.origin.x + padding)
		let y = max(min(self.origin.y, (rect.size.height - self.size.height) - padding), rect.origin.y + padding)
		
		return CGRect(origin: CGPoint(x: x, y: y), size: self.size)
	}
}

public extension CGSize {
	public func resize(to mode: ResizeMode, inside target: CGSize) -> CGSize {
		let width = target.width / self.width
		let height = target.height / self.height
		
		let ratio: CGFloat
		
		switch mode {
		case .fit:
			ratio = min(width, height)
		case .fill:
			ratio = max(width, height)
		}
		
		return CGSize(width: self.width * ratio, height: self.height * ratio)
	}
}
