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
		let difference = abs(self.timeIntervalSinceNow)
		
		if difference <= 15 {
			return "Just now"
		}
		
		for (time, divider, caption) in times {
			if difference <= time {
				let amount = Int(round(difference / divider))
				
				let first = amount == 1 ? "One" : String(amount)
				let second = String.pluralise(amount: amount, caption)
				
				return "\(first) \(second) ago"
			}
		}
		
		return timeAgoFormatter.string(from: self)
	}
	
	public func isBetween(start: (day: Int, month: Int), end: (day: Int, month: Int)) -> Bool {
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

private let timeAgoFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.timeStyle = .none
	formatter.dateFormat = "d MMMM, y"
	
	return formatter
}()

private let second = 1.0
private let minute = 60.0
private let hour = 3600.0
private let day = 86400.0
private let week = 604800.0

private let times = [
	(second * 59, second, "second"),
	(minute * 59, minute, "minute"),
	(hour * 23, hour, "hour"),
	(day * 6, day, "day"),
	(week * 3, week, "week")
]
