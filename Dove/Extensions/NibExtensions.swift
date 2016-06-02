//
//  NibExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 02/06/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public extension UINib {
	public func createView() -> UIView? {
		let results = self.instantiateWithOwner(nil, options: nil)
		
		if let result = results.first {
			if let view = result as? UIView {
				return view
			}
		}
		
		return nil
	}
}
