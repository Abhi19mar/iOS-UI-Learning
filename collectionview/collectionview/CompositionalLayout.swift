//
//  CompositionalLayout.swift
//  collectionview
//
//  Created by Abhishek Goel on 15/12/22.
//

import UIKit

enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}
struct CompositionalLayout  {
    
    static func createItem(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, spacing: CGFloat) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height))
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return item
    }
    
    static func createGroup(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, alignment: CompositionalGroupAlignment, item: NSCollectionLayoutItem, count: Int) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
        }
    }
    
    static func createGroup(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, alignment: CompositionalGroupAlignment, items: [NSCollectionLayoutItem], spacing: CGFloat) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
            group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            return group
        case .horizontal:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
            group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            return group
        }
    }
}
