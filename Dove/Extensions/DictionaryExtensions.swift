//
//  DictionaryExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 10/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Dictionary where Key: Hashable {
	public func collapse<Key, Value>(_ transform: (Element) -> (Key?, Value?)) -> [Key: Value] {
		let transforms = self.map(transform)
		var result = [Key: Value]()
		
		for (key, value) in transforms {
			if let key = key, let value = value {
				result[key] = value
			}
		}
		
		return result
	}
}

public extension Dictionary {
	public var urlQuery: String {
		let query = self
			.collapse({ (String(describing: $0).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), String(describing: $1).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) })
			.map({ "\($0.key)=\($0.value)" })
			.joined(separator: "&")
		
		return "?\(query)"
	}
	
	public var random: (Key, Value)? {
		if self.count <= 0 {
			return nil
		}
		
		let keys = Array(self.keys)
		let values = Array(self.values)
		
		let index = Int(arc4random_uniform(UInt32(self.count)))
		
		return (keys[index], values[index])
	}
}

public func unwrap<Key, Value>(_ dictionary: [Key: Value?]) -> [Key: Value] {
	var result = [Key: Value]()
	
	for (key, value) in dictionary {
		if let value = value {
			result[key] = value
		}
	}
	
	return result
}

public func +<Key, Value>(first: [Key: Value]?, second: [Key: Value]?) -> [Key: Value] {
	var result = [Key: Value]()
	
	if let first = first {
		for (key, value) in first {
			result[key] = value
		}
	}
	
	if let second = second {
		for (key, value) in second {
			result[key] = value
		}
	}
	
	return result
}
