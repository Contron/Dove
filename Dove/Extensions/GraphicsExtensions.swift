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
	public enum AspectPriority {
		case automatic
		case width
		case height
	}
	
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

public extension CGRect {
	public enum ResizeMode {
		case fit
		case fill
	}
	
	public static func resize(to mode: ResizeMode, size: CGSize, inside rect: CGRect) -> CGRect {
		let width = rect.size.width / size.width
		let height = rect.size.height / size.height
		
		let ratio: CGFloat
		
		switch mode {
		case .fit:
			ratio = min(width, height)
		case .fill:
			ratio = max(width, height)
		}
		
		let size = CGSize(width: size.width * ratio, height: size.height * ratio)
		let origin = CGPoint(x: (rect.size.width - size.width) / 2, y: (rect.size.height - size.height) / 2)
		
		return CGRect(origin: origin, size: size)
	}
	
	func fitting(to frame: CGRect, padding: CGFloat) -> CGRect {
		let x = max(min(self.origin.x, (frame.size.width - self.size.width) - padding), frame.origin.x + padding)
		let y = max(min(self.origin.y, (frame.size.height - self.size.height) - padding), frame.origin.y + padding)
		
		return CGRect(origin: CGPoint(x: x, y: y), size: self.size)
	}
}
