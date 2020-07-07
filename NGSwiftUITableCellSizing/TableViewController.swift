//
//  TableViewController.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/6/20.
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

final class TableViewController: UITableViewController {
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.tableView.register(HostingCell<CellView>.self, forCellReuseIdentifier: "HostingCell<CellView>")
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<CellView>", for: indexPath) as! HostingCell<CellView>
        cell.set(rootView: CellView(content: "Title Title Title ", numberOfRepetitions: indexPath.row % 20 + 1), parentController: self)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath)")
    }
}
