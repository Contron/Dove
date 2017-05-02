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
	public func create() -> UIView? {
		return self.instantiate(withOwner: nil, options: nil).first as? UIView
	}
}
