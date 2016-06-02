//
//  Notification.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

class Notification {
	init(name: String) {
		self.name = name
	}
	
	let name: String
	
	var identifier: String {
		return "\(name)Notification"
	}
}

extension NSNotificationCenter {
	func post(notification: Notification, sender: AnyObject?, parameters: [String: AnyObject]?) {
		NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: notification.identifier, object: sender, userInfo: parameters))
	}
	
	func subscribe(notification: Notification, observer: AnyObject, selector: Selector) {
		NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: notification.identifier, object: nil)
	}
	
	func unsubscribe(notification: Notification, observer: AnyObject) {
		NSNotificationCenter.defaultCenter().removeObserver(observer, name: notification.identifier, object: nil)
	}
}
