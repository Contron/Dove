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
		let singular = singular.hasSuffix("s") ? singular.substringToIndex(singular.endIndex.predecessor()) : singular
		let plural = plural ?? "\(singular)s"
		
		return count == 1 ? singular : plural
	}

	public func truncate(length: Int) -> String {
		if self.characters.count > length {
			return self.substringToIndex(self.startIndex.advancedBy(length)) + "..."
		}
		
		return self
	}
}

public extension Int {
	public var displayValue: String {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.groupingSeparator = ","
		
		return formatter.stringFromNumber(self) ?? String(self)
	}
}

public extension Double {
	public var displayValue: String {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.groupingSeparator = ","
		formatter.maximumFractionDigits = 3
		
		return formatter.stringFromNumber(self) ?? String(self)
	}
}
