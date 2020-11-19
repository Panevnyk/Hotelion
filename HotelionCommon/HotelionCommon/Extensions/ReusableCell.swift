//
//  ReusableCell.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//

import UIKit

// MARK: - className
extension NSObject {
    public var className: String {
        return String(describing: type(of: self))
    }

    public class var className: String {
        return String(describing: self)
    }
}

// MARK: - Register UITableViewCell
extension UITableView {
    public func register<T: UITableViewCell>(cell: T.Type, bundle: Bundle) {
        register(UINib(nibName: cell.className, bundle: bundle),
                 forCellReuseIdentifier: cell.className)
    }
}

// MARK: - Register UICollectionViewCell
extension UICollectionView {
    public func register<T: UICollectionViewCell>(cell: T.Type, bundle: Bundle) {
        register(UINib(nibName: cell.className, bundle: bundle),
                 forCellWithReuseIdentifier: cell.className)
    }

    public func register<T: UICollectionReusableView>(cell: T.Type, kind: String, bundle: Bundle) {
        register(UINib(nibName: cell.className, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: cell.className)
    }
}

// MARK: - Reusable UITableViewCell
extension UITableView {
    public func dequeueReusableCellWithIndexPath<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }
}

// MARK: - Reusable UICollectionViewCell
extension UICollectionView {
    public func dequeueReusableCellWithIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }

    public func dequeueReusableSupplementaryViewWithIndexPath<T: UICollectionReusableView>(_ indexPath: IndexPath, kind: String) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't dequeue reusable supplementaryView with identifier: \(T.className)")
        }
        return view
    }
}
