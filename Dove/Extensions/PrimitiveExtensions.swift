//
//  PrimitiveExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

infix operator ?=: AssignmentPrecedence

public func ?= <Value>(first: inout Value, second: Value?) {
	return first = second ?? first
}

public extension String {
	public enum ConversionCase {
		case camel
		case pascal
		case title
		case snake
		case kebab
	}
	
	public static func replace(transforms: [String: Any]) -> String {
		var result = String(describing: self)
		
		transforms.forEach({ result = result.replacingOccurrences(of: $0.key, with: String(describing: $0.value)) })
		
		return result
	}
	
	public static func generate(length: Int) -> String {
		var result = String()
		
		for _ in 1...length {
			let offset = Int(arc4random_uniform(UInt32(letters.count)))
			let index = letters.index(letters.startIndex, offsetBy: offset)
			
			result.append(letters[index])
		}
		
		return result
	}
	
	public func convert(case: ConversionCase) -> String {
		switch `case` {
		case .camel:
			return String(self.prefix(1)).lowercased() + String(self.dropFirst())
		case .pascal:
			return String(self.prefix(1)).uppercased() + String(self.dropFirst())
		case .title:
			return self.replacingOccurrences(of: regex, with: "$1 $2", options: .regularExpression, range: self.startIndex..<self.endIndex).capitalized
		case .snake:
			return self.replacingOccurrences(of: regex, with: "$1_$2", options: .regularExpression, range: self.startIndex..<self.endIndex).lowercased()
		case .kebab:
			return self.replacingOccurrences(of: regex, with: "$1-$2", options: .regularExpression, range: self.startIndex..<self.endIndex).lowercased()
		}
	}
	
	public func truncate(to length: Int) -> String {
		guard self.count > length else {
			return self
		}
		
		return self.prefix(length) + "..."
	}
	
	public var url: URL? {
		return URL(string: self)
	}
}

public extension Int {
	public static func random(maximum: Int) -> Int {
		return Int(arc4random_uniform(UInt32(maximum)))
	}
	
	public func align(to number: Int) -> Int {
		return Int(round(Double(self) / Double(number))) * number
	}
	
	public var ordinalValue: String {
		return ordinalFormatter.string(from: NSNumber(value: self)) ?? String(self)
	}
	
	public var displayValue: String {
		return integerFormatter.string(from: NSNumber(value: self)) ?? String(self)
	}
}

public extension Double {
	public var displayValue: String {
		return doubleFormatter.string(from: NSNumber(value: self)) ?? String(self)
	}
	
	public var percentageValue: String {
		return percentageFormatter.string(from: NSNumber(value: self)) ?? String(self)
	}
}

public extension FloatingPoint {
	public static var random: Self {
		return Self(arc4random()) / Self(UInt32.max)
	}
	
	public var radians: Self {
		return self * .pi / 180
	}
	
	public var degrees: Self {
		return self * 180 / .pi
	}
}

public extension Date {
	public var displayValue: String {
		return dateFormatter.string(from: self)
	}
}

private let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
private let regex = "([a-z])([A-Z])"

private let integerFormatter: NumberFormatter = {
	let formatter = NumberFormatter()
	formatter.numberStyle = .decimal
	formatter.groupingSeparator = ","
	
	return formatter
}()

private let ordinalFormatter: NumberFormatter = {
	let formatter = NumberFormatter()
	formatter.numberStyle = .ordinal
	
	return formatter
}()

private let doubleFormatter: NumberFormatter = {
	let formatter = NumberFormatter()
	formatter.numberStyle = .decimal
	formatter.groupingSeparator = ","
	formatter.maximumFractionDigits = 3
	
	return formatter
}()

private let percentageFormatter: NumberFormatter = {
	let formatter = NumberFormatter()
	formatter.numberStyle = .percent
	formatter.maximumFractionDigits = 2
	
	return formatter
}()

private let dateFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .long
	formatter.timeStyle = .long
	
	return formatter
}()
