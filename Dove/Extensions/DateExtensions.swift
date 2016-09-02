//
//  DateExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension NSDate {
	public func timeAgo() -> String {
		let difference = abs(self.timeIntervalSinceNow)
		
		if difference <= 15 {
			return "Just Now"
		}
		
		for (time, divider, caption) in times {
			if difference <= time {
				let amount = Int(round(difference / divider))
				let caption = String.pluralise(amount, singular: caption, plural: nil)
				
				return "\(amount) \(caption) Ago"
			}
		}
		
		let formatter = NSDateFormatter()
		formatter.timeStyle = .NoStyle
		formatter.dateStyle = .MediumStyle
		
		return formatter.stringFromDate(self)
	}
	
	func isEarlier(date: NSDate) -> Bool {
		return self.compare(date) == .OrderedAscending
	}
	
	func isLater(date: NSDate) -> Bool {
		return self.compare(date) == .OrderedDescending
	}
	
	func isEarlierThanNow() -> Bool {
		return self.isEarlier(NSDate())
	}
	
	func isLaterThanNow() -> Bool {
		return self.isLater(NSDate())
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
