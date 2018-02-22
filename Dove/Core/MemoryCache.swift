//
//  MemoryCache.swift
//  Dove
//
//  Created by Connor Haigh on 19/01/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public final class MemoryCache<Key: Hashable, Value> {
	public init() {
		self.cache.name = "Cache"
	}
	
	public func add(_ value: Value, for key: Key, costing amount: Int) {
		self.cache.setObject(value as AnyObject, forKey: key as AnyObject, cost: amount)
	}
	
	public func remove(_ key: Key) {
		self.cache.removeObject(forKey: key as AnyObject)
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
	
	public var name: String {
		get {
			return self.cache.name
		}
		set {
			self.cache.name = newValue
		}
	}
	
	public var maximumCount: Int {
		get {
			return self.cache.countLimit
		}
		set {
			self.cache.countLimit = newValue
		}
	}
	
	public var maximumCost: Int {
		get {
			return self.cache.totalCostLimit
		}
		set {
			self.cache.totalCostLimit = newValue
		}
	}
	
	private let cache = NSCache<AnyObject, AnyObject>()
}
