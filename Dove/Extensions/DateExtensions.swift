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
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(abbreviation: "UTC")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		if let date = formatter.date(from: string) {
			self.init(timeInterval: 0, since: date)
		} else {
			return nil
		}
	}
	
	public func timeAgo() -> String {
		let difference = abs(self.timeIntervalSinceNow)
		
		if difference <= 15 {
			return "just now"
		}
		
		for (time, divider, caption) in times {
			if difference <= time {
				let amount = Int(round(difference / divider))
				
				let first = amount == 1 ? "one" : String(amount)
				let second = String.pluralise(amount: amount, singular: caption, plural: nil)
				
				return "\(first) \(second) ago"
			}
		}
		
		let formatter = DateFormatter()
		formatter.timeStyle = .none
		formatter.dateFormat = "d MMMM, y"
		
		return formatter.string(from: self)
	}
	
	public func isBetween(startMonth: Int, startDay: Int, endMonth: Int, endDay: Int) -> Bool {
		let calendar = Calendar(identifier: .gregorian)
		
		let day = calendar.component(.day, from: self)
		let month = calendar.component(.month, from: self)
		
		return (month >= startMonth && day >= startDay) && (month <= endMonth && day <= endDay)
	}

	public func isPast() -> Bool {
		return self < Date()
	}
	
	public func isFuture() -> Bool {
		return self > Date()
	}
}

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
