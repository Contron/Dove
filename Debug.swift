//
//  Debug.swift
//  Dove
//
//  Created by Connor Haigh on 09/08/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

func debug(object: Any, file: String = #file) {
	#if DEBUG
		let formatter = NSDateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		
		let date = formatter.stringFromDate(NSDate()) ?? "Now"
		
		let file = NSURL(string: file)?.URLByDeletingPathExtension?.lastPathComponent ?? "Unknown"
		let object = String(object)
		
		print("[\(date) \(file)] \(object)")
	#endif
}
