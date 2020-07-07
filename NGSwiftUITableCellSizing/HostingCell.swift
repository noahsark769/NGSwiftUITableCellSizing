//
//  HostingCell.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/7/20.
//

import Foundation
import UIKit
import SwiftUI

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
//        return hostingController.sizeThatFits(in: size)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        hostingController.view.frame.size = self.sizeThatFits(bounds.size)
//    }
//
//    public func set(rootView: Content, parentController: UIViewController) {
//        self.hostingController.rootView = rootView
//
//        let requiresControllerMove = hostingController.parent != parentController
//        if requiresControllerMove {
//            parentController.addChild(hostingController)
//        }
//
//        if !self.contentView.subviews.contains(hostingController.view) {
//            self.contentView.addSubview(hostingController.view)
//        }
//
//        if requiresControllerMove {
//            hostingController.didMove(toParent: parentController)
//        }
//    }
//}

/// OTHER METHOD

final class HostingCell<Content: View>: UITableViewCell {
    var parentController: UIViewController?
    private lazy var hostingView: HostingView<Content?> = HostingView(rootView: nil)

    private var rootView: Content? {
        get { hostingView.rootView }
        set {
            hostingView.rootView = newValue
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(hostingView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        hostingView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        hostingView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        hostingView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        let bottom = hostingView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        bottom.priority = .defaultHigh
        bottom.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(rootView: Content, parentController: UIViewController) {
        self.rootView = rootView
        self.parentController = parentController
        self.hostingView.parentController = parentController
    }
}

class HostingView<Content: View>: UIView {
    var parentController: UIViewController? {
        didSet {
            self.setupController()
            self.rootViewHostingController.view.invalidateIntrinsicContentSize()
        }
    }

    let rootViewHostingController: UIHostingController<Content>

    public var rootView: Content {
        get {
            return rootViewHostingController.rootView
        } set {
            rootViewHostingController.rootView = newValue
        }
    }

    public required init(rootView: Content) {
        self.rootViewHostingController = UIHostingController(rootView: rootView)

        super.init(frame: .zero)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupController() {
        guard let parentController = self.parentController, rootViewHostingController.parent != rootViewHostingController else { return }
        rootViewHostingController.view.backgroundColor = .clear

        parentController.addChild(rootViewHostingController)
        addSubview(rootViewHostingController.view)

        rootViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        rootViewHostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rootViewHostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rootViewHostingController.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rootViewHostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        rootViewHostingController.didMove(toParent: self.parentController)
    }
}
