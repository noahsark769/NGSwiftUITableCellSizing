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

final class WrapperController<Content: View>: UIViewController {
    let wrappedController: UIHostingController<Content>

    init(wrappedController: UIHostingController<Content>) {
        self.wrappedController = wrappedController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wrappedController.willMove(toParent: self)
        self.addChild(wrappedController)
        self.view.addSubview(wrappedController.view)

        wrappedController.view.translatesAutoresizingMaskIntoConstraints = false
        wrappedController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        wrappedController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        wrappedController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        wrappedController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

// Constraints method

final class HostingCell<Content: View>: UITableViewCell {
    private let hostingController = WrapperController<Content?>(wrappedController: UIHostingController<Content?>(rootView: nil))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hostingController.wrappedController.view.backgroundColor = .clear
        self.contentView.insetsLayoutMarginsFromSafeArea = false
        self.insetsLayoutMarginsFromSafeArea = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func safeAreaInsetsDidChange() {
        print("SAFE AREA CHANGING!!")
    }

    override var safeAreaInsets: UIEdgeInsets {
        return .zero
    }

    override var safeAreaLayoutGuide: UILayoutGuide {
        return UILayoutGuide()
    }

    func set(rootView: Content, parentController: UIViewController) {
        self.hostingController.wrappedController.rootView = rootView
//        self.hostingController.view.insetsLayoutMarginsFromSafeArea = false
        self.hostingController.wrappedController.view.invalidateIntrinsicContentSize()
//        self.hostingController.view.setNeedsLayout()
//        self.hostingController.view.setNeedsUpdateConstraints()

        let requiresControllerMove = hostingController.parent != parentController
        if requiresControllerMove {
            parentController.addChild(hostingController)
        }

        if !self.contentView.subviews.contains(hostingController.view) {
            self.contentView.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            hostingController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            hostingController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            hostingController.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parentController)
        }
    }
}
