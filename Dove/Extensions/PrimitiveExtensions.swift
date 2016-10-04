//
//  PrimitiveExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension String {
	public static func pluralise(count: Int, singular: String, plural: String?) -> String {
		let singular = singular.hasSuffix("s") ? singular.substring(to: singular.characters.index(before: singular.endIndex)) : singular
		let plural = plural ?? "\(singular)s"
		
		return count == 1 ? singular : plural
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
	
	public var displayValue: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = ","
		
		return formatter.string(from: NSNumber(value: self)) ?? String(self)
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
