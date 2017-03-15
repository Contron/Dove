//
//  PrimitiveExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension String {
	public enum Case {
		case camel
		case pascal
		case title
		case snake
		case kebab
	}
	
	public static func pluralise(amount: Int, singular: String, plural: String? = nil) -> String {
		let singular = singular.hasSuffix("s") || singular.hasSuffix("S") ? singular.substring(to: singular.characters.index(before: singular.endIndex)) : singular
		let plural = plural ?? "\(singular)s"
		
		return amount == 1 ? singular : plural
	}
	
	public static func stitch(strings: [String]) -> String? {
		var strings = strings
		
		guard let last = strings.popLast() else {
			return nil
		}
		
		if strings.count > 0 {
			let message = strings.joined(separator: ", ")
			
			return "\(message) and \(last)"
		} else {
			return last
		}
	}
	
	public static func generate(length: Int) -> String {
		var result = String()
		
		for _ in 1...length {
			let offset = Int(arc4random_uniform(UInt32(letters.characters.count)))
			let index = letters.characters.index(letters.characters.startIndex, offsetBy: offset)
			
			result.append(letters.characters[index])
		}
		
		return result
	}
	
	public func convert(case: Case) -> String {
		switch `case` {
		case .camel:
			return String(self.characters.prefix(1)).lowercased() + String(self.characters.dropFirst())
		case .pascal:
			return String(self.characters.prefix(1)).uppercased() + String(self.characters.dropFirst())
		case .title:
			return self.replacingOccurrences(of: regex, with: "$1 $2", options: .regularExpression, range: self.startIndex..<self.endIndex).capitalized
		case .snake:
			return self.replacingOccurrences(of: regex, with: "$1_$2", options: .regularExpression, range: self.startIndex..<self.endIndex).lowercased()
		case .kebab:
			return self.replacingOccurrences(of: regex, with: "$1-$2", options: .regularExpression, range: self.startIndex..<self.endIndex).lowercased()
		}
	}
	
	public func truncate(length: Int) -> String {
		if self.characters.count > length {
			return self.substring(to: self.characters.index(self.startIndex, offsetBy: length)) + "..."
		}
		
		return self
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
				return "\(self)st"
			case 2:
				return "\(self)nd"
			case 3:
				return "\(self)rd"
			default:
				break
			}
		}
		
		return "\(self)th"
	}
	
	public var date: Date {
		return Date(timeIntervalSince1970: Double(self))
	}
	
	public var displayValue: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = ","
		
		return formatter.string(from: NSNumber(value: self)) ?? String(self)
	}
}

public extension Double {
	public var date: Date {
		return Date(timeIntervalSince1970: Double(self))
	}
	
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
	case let value as String:
		return "\"\(value)\""
	case let value as Bool:
		return value ? "true" : "false"
	default:
		return String(describing: value)
	}
}

private let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
private let regex = "([a-z])([A-Z])"
