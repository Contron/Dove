//
//  PrimitiveExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension String {
	public static func pluralise(amount: Int, singular: String, plural: String? = nil) -> String {
		let singular = singular.hasSuffix("s") || singular.hasSuffix("S") ? singular.substring(to: singular.characters.index(before: singular.endIndex)) : singular
		let plural = plural ?? "\(singular)s"
		
		return amount == 1 ? singular : plural
	}
	
	public func truncate(length: Int) -> String {
		if self.characters.count > length {
			return self.substring(to: self.characters.index(self.startIndex, offsetBy: length)) + "..."
		}
		
		return self
	}
	
	public var pascalCase: String {
		guard let first = self.characters.first else {
			return self
		}
		
		return String(first).uppercased() + String(self.characters.dropFirst(1))
	}
}

public extension Int {
	public static func align(number: Int, steps: Int) -> Int {
		return Int(round(Double(number) / Double(steps))) * steps
	}
	
	public var ordinal: String {
		let ones = self % 10
		let tens = (self / 10) % 10
		
		if tens != 1 {
			switch ones {
			case 1:
				return "st"
			case 2:
				return "nd"
			case 3:
				return "rd"
			default:
				break
			}
		}
		
		return "th"
	}
	
	public var displayValue: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = ","
		
		return formatter.string(from: NSNumber(value: self)) ?? String(self)
	}
}

public extension Double {
	public var displayValue: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = ","
		formatter.maximumFractionDigits = 3
		
		return formatter.string(from: NSNumber(value: self)) ?? String(self)
	}
}

public func inspect(_ value: Any) -> String {
	switch value {
	case let value as [AnyHashable: Any]:
		return "{\(value.map({ "\($0): \(inspect($1))" }).joined(separator: ", "))}"
	case let value as [Any]:
		return "[\(value.map({ inspect($0) }).joined(separator: ", "))]"
	case let value as Bool:
		return value ? "true" : "false"
	default:
		return String(describing: value)
	}
}
