//
//  StringExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension String {
	public static func pluralise(count: Int, singular: String, plural: String?) -> String {
		return count == 1 ? singular : plural ?? "\(singular)s"
	}
}
