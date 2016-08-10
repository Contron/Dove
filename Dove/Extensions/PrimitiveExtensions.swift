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
		return count == 1 ? singular : plural ?? "\(singular)s"
	}
	
	func truncate(length: Int) -> String {
		if self.characters.count > length {
			return self.substringToIndex(self.startIndex.advancedBy(length)) + "..."
		}
		
		return self
	}
}

extension Int {
	var displayValue: String {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.groupingSeparator = ","
		
		return formatter.stringFromNumber(self) ?? String(self)
	}
}
