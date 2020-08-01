//
//  HostingCell.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/7/20.
//

import Foundation
import UIKit
import SwiftUI

// sizeThatFits method
//final class HostingCell<Content: View>: UITableViewCell {
//    private lazy var hostingController: UIHostingController<Content?> = UIHostingController(rootView: nil)
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        hostingController.view.backgroundColor = .clear
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        let size = hostingController.sizeThatFits(in: size)
//        print("Returning size \(size)")
//        return size
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        hostingController.view.frame.size = self.sizeThatFits(bounds.size)
//    }
//
//    public func set(rootView: Content, parentController: UIViewController) {
//        self.hostingController.rootView = rootView
//        if !self.contentView.subviews.contains(hostingController.view) {
//            self.contentView.addSubview(hostingController.view)
//        }
//    }
//}

// Constraints method

final class HostingCell<Content: View>: UITableViewCell {
    private let hostingController = UIHostingController<Content?>(rootView: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hostingController.view.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(rootView: Content, parentController: UIViewController) {
        self.hostingController.rootView = rootView
        self.hostingController.view.invalidateIntrinsicContentSize()

        let requiresControllerMove = hostingController.parent != parentController
        if requiresControllerMove {
            parentController.addChild(hostingController)
        }

        if !self.contentView.subviews.contains(hostingController.view) {
            self.contentView.addSubview(hostingController.view)
            hostingController.view.constraintsEqualTo(contentView)
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parentController)
        }
    }
}

extension UIView {
    func constraintsEqualTo(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
