//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	public mutating func remove(element: Element) {
		guard let index = self.index(of: element) else {
			return
		}
		
		self.remove(at: index)
	}
	
	public func contains(array: [Element]) -> Bool {
		return self.contains(where: { array.contains($0) })
	}
}

public func unwrap<Element>(_ array: [Element?]) -> [Element] {
	return array.reduce(into: [Element](), { result, element in
		guard let element = element else {
			return
		}
		
		result.append(element)
	})
}
