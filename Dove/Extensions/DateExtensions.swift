//
//  DateExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Date {
	public init?(string: String) {
		guard let date = posixFormatter.date(from: string) else {
			return nil
		}
		
		self.init(timeInterval: 0, since: date)
	}
	
	public func timeAgo() -> String {
		return "\(timeAgoFormatter.string(from: self, to: .now) ?? "Time") ago"
	}
	
	public func between(start: (day: Int, month: Int), end: (day: Int, month: Int)) -> Bool {
		let day = Calendar.current.component(.day, from: self)
		let month = Calendar.current.component(.month, from: self)
		
		return (day >= start.day && month >= start.month) && (day <= end.day && month <= end.month)
	}
	
	public func isPast() -> Bool {
		return self < .now
	}
	
	public func isFuture() -> Bool {
		return self > .now
	}
	
	public static var now: Date {
		return Date()
	}
}

private let posixFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.locale = Locale(identifier: "en_US_POSIX")
	formatter.timeZone = TimeZone(abbreviation: "UTC")
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
	
	return formatter
}()

private let timeAgoFormatter: DateComponentsFormatter = {
	let formatter = DateComponentsFormatter()
	formatter.maximumUnitCount = 1
	formatter.unitsStyle = .full
	
	return formatter
}()
