//
//  DateExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension Date {
	public func timeAgo() -> String {
		let difference = abs(self.timeIntervalSinceNow)
		
		if difference <= 15 {
			return "Just Now"
		}
		
		for (time, divider, caption) in times {
			if difference <= time {
				let amount = Int(round(difference / divider))
				let caption = String.pluralise(amount: amount, singular: caption, plural: nil)
				
				return "\(amount) \(caption) Ago"
			}
		}
		
		let formatter = DateFormatter()
		formatter.timeStyle = .none
		formatter.dateFormat = "d MMMM, y"
		
		return formatter.string(from: self)
	}
	
	public func isBetween(startMonth: Int, startDay: Int, endMonth: Int, endDay: Int) -> Bool {
		let calendar = Calendar(identifier: .gregorian)
		let date = Date()
		
		let day = calendar.component(.day, from: date)
		let month = calendar.component(.month, from: date)
		
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
	(second * 59, second, "Second"),
	(minute * 59, minute, "Minute"),
	(hour * 23, hour, "Hour"),
	(day * 6, day, "Day"),
	(week * 2, week, "Week")
]
