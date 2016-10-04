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
}

public extension Int {
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
