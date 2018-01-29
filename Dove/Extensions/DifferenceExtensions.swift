//
//  DifferenceExtensions.swift
//  Dove
//
//  Created by Connor Haigh on 29/01/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation

public extension IndexPath {
	public static func difference<Element: Equatable>(from old: [Element], to new: [Element]) -> (insertions: [IndexPath], deletions: [IndexPath]) {
		let insertions = new.filter({ !old.contains($0) }).flatMap({ new.index(of: $0) }).map({ IndexPath(row: $0, section: 0) })
		let deletions = old.filter({ !new.contains($0) }).flatMap({ old.index(of: $0) }).map({ IndexPath(row: $0, section: 0) })
		
		return (insertions, deletions)
	}
}
