//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
	func allEqual<T: Equatable>(predicate: Element -> T) -> Bool {
		if let first = self.first {
			let first = predicate(first)
			
			for element in self {
				let element = predicate(element)
				
				if element != first {
					return false
				}
			}
		}
		
		return true
	}
	
	func distinct() -> [Element] {
		var results = [Element]()
		
		for element in self {
			if !results.contains(element) {
				results.append(element)
			}
		}
		
		return results
	}
}

extension Array {
	func any(predicate: Element -> Bool) -> Bool {
		return self.count(predicate) > 0
	}
	
	func all(predicate: Element -> Bool) -> Bool {
		return self.count(predicate) == self.count
	}
	
	func count(predicate: Element -> Bool) -> Int {
		var count = 0
		
		for element in self {
			if predicate(element) {
				count += 1
			}
		}
		
		return count
	}
}
