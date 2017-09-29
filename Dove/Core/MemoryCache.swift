//
//  MemoryCache.swift
//  Dove
//
//  Created by Connor Haigh on 19/01/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public class MemoryCache<Key, Value> where Key: Hashable {
	public init() {
		
	}
	
	public func contains(_ key: Key) -> Bool {
		return self.cache.object(forKey: key as AnyObject) != nil
	}
	
	public func clear() {
		self.cache.removeAllObjects()
	}
	
	public subscript(_ key: Key) -> Value? {
		get {
			return self.cache.object(forKey: key as AnyObject) as? Value
		}
		set {
			self.cache.setObject(newValue as AnyObject, forKey: key as AnyObject)
		}
	}
	
	private let cache = NSCache<AnyObject, AnyObject>()
}
