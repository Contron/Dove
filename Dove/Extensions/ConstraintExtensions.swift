//
//  ConstraintExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 21/10/2016.
//  Copyright © 2016 Connor Haigh. All rights reserved.
//

import Foundation

public extension UIView {
	public func constraintSuperview(constant: CGFloat? = nil) {
		guard let parent = self.superview else {
			return
		}
		
		if let constant = constant {
			self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant).isActive = true
			self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: constant).isActive = true
			self.topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
			self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: constant).isActive = true
		} else {
			self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
			self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
		}
	}
	
	public func constraintSuperviewCenter(offset: CGSize? = nil) {
		guard let parent = self.superview else {
			return
		}
		
		if let offset = offset {
			self.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.width).isActive = true
			self.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.height).isActive = true
		} else {
			self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
			self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
		}
	}
	
	public func constraintSize(size: CGSize) {
		self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
		self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
	}
}
