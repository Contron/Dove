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

public extension Dictionary where Value: Hashable {
	public func contains(value: Value) -> Bool {
		return self.values.contains(value)
	}
}

public extension Dictionary where Key == String {
	public func instantiate<Target: RawRepresentable>(to target: Target.Type) -> [Target: Value] where Target.RawValue == String {
		return self.reduce(into: [Target: Value](), { result, element in
			guard let target = Target(rawValue: element.key) else {
				return
			}
			
			result[target] = element.value
		})
	}
}

public func unwrap<Key, Value>(_ dictionary: [Key: Value?]) -> [Key: Value] {
	return dictionary.reduce(into: [Key: Value](), { result, element in
		guard let value = element.value else {
			return
		}
		
		result[element.key] = value
	})
}
