//
//  ArrayExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public func unwrap<T>(_ array: [T?]) -> [T] {
	return array.reduce(into: [T](), { result, element in
		guard let element = element else {
			return
		}
		
		result.append(element)
	})
}
