//
//  CalendarExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 06/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public extension Calendar {
	public func startOfYear(for date: Date) -> Date {
		return self.date(from: self.dateComponents([.year, .era], from: self.startOfDay(for: date)))!
	}
	
	public func startOfMonth(for date: Date) -> Date {
		return self.date(from: self.dateComponents([.month, .year, .era], from: self.startOfDay(for: date)))!
	}
	
	public func startOfWeek(for date: Date) -> Date {
		return self.date(from: self.dateComponents([.weekOfMonth, .month, .year, .era], from: self.startOfDay(for: date)))!
	}
	
	public func endOfYear(for date: Date) -> Date {
		return self.date(byAdding: DateComponents(year: 1, day: -1), to: self.startOfYear(for: date), wrappingComponents: true)!
	}
	
	public func endOfMonth(for date: Date) -> Date {
		return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(for: date), wrappingComponents: true)!
	}
	
	public func endOfWeek(for date: Date) -> Date {
		return self.date(byAdding: DateComponents(day: -1, weekOfMonth: 1), to: self.startOfWeek(for: date), wrappingComponents: true)!
	}
	
	public func date(byRounding component: Component, every value: Int, of date: Date) -> Date? {
		return self.date(bySetting: component, value: Int(ceil(Double(self.component(component, from: date)) / Double(value))) * value, of: date)
	}
}
