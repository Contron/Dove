//
//  CollectionExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 03/10/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation

public extension RangeReplaceableCollection where Element: Equatable {
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
