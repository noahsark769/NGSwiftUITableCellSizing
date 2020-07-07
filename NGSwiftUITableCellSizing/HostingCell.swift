//
//  HostingCell.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/7/20.
//

import Foundation
import UIKit
import SwiftUI

final class HostingCell<Content: View>: UITableViewCell {
    private lazy var hostingController: UIHostingController<Content?> = UIHostingController(rootView: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hostingController.view.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return hostingController.sizeThatFits(in: size)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hostingController.view.frame.size = self.sizeThatFits(bounds.size)
    }

    public func set(rootView: Content, parentController: UIViewController) {
        self.hostingController.rootView = rootView

        let requiresControllerMove = hostingController.parent != parentController
        if requiresControllerMove {
            parentController.addChild(hostingController)
        }

        if !self.contentView.subviews.contains(hostingController.view) {
            self.contentView.addSubview(hostingController.view)
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parentController)
        }
    }
}
