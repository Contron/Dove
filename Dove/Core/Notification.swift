//
//  Notification.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public class Notification {
	public init(name: String) {
		self.name = name
	}
	
	public let name: String
	
	public var identifier: String {
		return "\(name)Notification"
	}
}

public extension NSNotificationCenter {
	public func post(notification: Notification, sender: AnyObject?, parameters: [String: AnyObject]?) {
		NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: notification.identifier, object: sender, userInfo: parameters))
	}
	
	public func post(notification: Notification, sender: AnyObject?) {
		self.post(notification, sender: sender, parameters: nil)
	}
	
	public func post(notification: Notification) {
		self.post(notification, sender: nil)
	}
	
	public func addObserver(notification: Notification, observer: AnyObject, selector: Selector) {
		NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: notification.identifier, object: nil)
	}
	
	public func removeObserver(notification: Notification, observer: AnyObject) {
		NSNotificationCenter.defaultCenter().removeObserver(observer, name: notification.identifier, object: nil)
	}
}
