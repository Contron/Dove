//
//  CalendarExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 06/10/2017.
//  Copyright © 2017 Connor Haigh. All rights reserved.
//

import Foundation

public extension Calendar {
	public typealias Period = (day: Int, month: Int)
	
	public func startOfYear(for date: Date) -> Date? {
		return self.date(from: self.dateComponents([.year, .era], from: self.startOfDay(for: date)))
	}
	
	public func startOfMonth(for date: Date) -> Date? {
		return self.date(from: self.dateComponents([.month, .year, .era], from: self.startOfDay(for: date)))
	}
	
	public func startOfWeek(for date: Date) -> Date? {
		return self.date(from: self.dateComponents([.weekOfMonth, .month, .year, .era], from: self.startOfDay(for: date)))
	}
	
	public func date(byRounding component: Component, every value: Int, of date: Date) -> Date? {
		return self.date(byAdding: component, value: value - (self.component(component, from: date) % value), to: date)
	}
	
	public func isDateBetween(date: Date, start: Period, end: Period) -> Bool {
		let day = self.component(.day, from: date)
		let month = self.component(.month, from: date)
		
		return (day >= start.day && month >= start.month) && (day <= end.day && month <= end.month)
	}
}
