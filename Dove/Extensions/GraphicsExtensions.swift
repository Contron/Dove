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
	
	public static func +(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x + value, y: point.y + value)
	}
	
	public static func -(point: CGPoint, value: CGFloat) -> CGPoint {
		return CGPoint(x: point.x - value, y: point.y - value)
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
	
	public static func +(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width + value, height: size.height + value)
	}
	
	public static func -(size: CGSize, value: CGFloat) -> CGSize {
		return CGSize(width: size.width - value, height: size.height - value)
	}
	
	public static func aspect(priority: AspectPriority, original: CGSize, target: CGSize) -> CGSize {
		let factor: CGFloat
		
		switch priority {
		case .automatic:
			factor = original.width > original.height ? target.width / original.width : target.height / original.height
		case .width:
			factor = target.width / original.width
		case .height:
			factor = target.height / original.height
		}
		
		return CGSize(width: original.width * factor, height: original.height * factor)
	}
}
