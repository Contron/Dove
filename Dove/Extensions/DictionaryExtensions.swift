//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary {
	public func contains(key: Key) -> Bool {
		return self.keys.contains(key)
	}
}

public extension Dictionary where Value: Equatable {
	public func contains(value: Value) -> Bool {
		return self.values.contains(value)
	}
}

public extension Dictionary where Key == String {
	public func instantiate<T: RawRepresentable>(to target: T.Type) -> [T: Value] where T.RawValue == String {
		return self.reduce(into: [T: Value](), { result, element in
			guard let target = T(rawValue: element.key) else {
				return
			}
			
			result[target] = element.value
		})
	}
}

public func unwrap<T, V>(_ dictionary: [T: V?]) -> [T: V] {
	return dictionary.reduce(into: [T: V](), { result, element in
		guard let value = element.value else {
			return
		}
		
		result[element.key] = value
	})
}
