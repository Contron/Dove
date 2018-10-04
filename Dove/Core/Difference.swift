//
//  Difference.swift
//  Dove
//
//  Created by Connor Haigh on 29/01/2018.
//  Copyright © 2018 Connor Haigh. All rights reserved.
//

import Foundation
import UIKit

public enum Difference {
	case deletion(index: Int)
	case insertion(index: Int)
	case move(oldIndex: Int, newIndex: Int)
	
	public static func calculate<T: Equatable>(from old: [T], to new: [T]) -> [Difference] {
		let deletions = old.compactMap({ element -> Difference? in
			guard let index = old.index(of: element), !new.contains(element) else {
				return nil
			}
			
			return .deletion(index: index)
		})
		
		let insertions = new.compactMap({ element -> Difference? in
			guard let index = new.index(of: element), !old.contains(element) else {
				return nil
			}
			
			return .insertion(index: index)
		})
		
		let moves = new.compactMap({ element -> Difference? in
			guard let oldIndex = old.index(of: element), let newIndex = new.index(of: element), oldIndex != newIndex else {
				return nil
			}
			
			return .move(oldIndex: oldIndex, newIndex: newIndex)
		})
		
		return deletions + insertions + moves
	}
}

public extension UICollectionView {
	public func reload(using differences: [Difference], in section: Int) {
		let indexes = Update(from: differences, in: section)
		
		self.performBatchUpdates({
			self.deleteItems(at: indexes.deletions)
			self.insertItems(at: indexes.insertions)
			
			for move in indexes.moves {
				self.moveItem(at: move.oldIndex, to: move.newIndex)
			}
		}, completion: nil)
	}
}

public extension UITableView {
	public func reload(using differences: [Difference], in section: Int, with animation: UITableView.RowAnimation) {
		let indexes = Update(from: differences, in: section)
		
		self.beginUpdates()
		self.deleteRows(at: indexes.deletions, with: animation)
		self.insertRows(at: indexes.insertions, with: animation)
		
		for move in indexes.moves {
			self.moveRow(at: move.oldIndex, to: move.newIndex)
		}
		
		self.endUpdates()
	}
}

private struct Update {
	public init(from differences: [Difference], in section: Int) {
		self.deletions = differences.compactMap({ difference -> IndexPath? in
			guard case let .deletion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: section)
		})
		
		self.insertions = differences.compactMap({ difference -> IndexPath? in
			guard case let .insertion(index) = difference else {
				return nil
			}
			
			return IndexPath(row: index, section: section)
		})
		
		self.moves = differences.compactMap({ difference -> (IndexPath, IndexPath)? in
			guard case let .move(oldIndex, newIndex) = difference else {
				return nil
			}
			
			return (IndexPath(row: oldIndex, section: section), IndexPath(row: newIndex, section: section))
		})
	}
	
	public let deletions: [IndexPath]
	public let insertions: [IndexPath]
	public let moves: [(oldIndex: IndexPath, newIndex: IndexPath)]
}
