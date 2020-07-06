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
    private let hostingView: HostingView<Content?> = HostingView(rootView: nil)

    var rootView: Content? {
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
        hostingView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

        hostingView.setContentHuggingPriority(.required, for: .vertical)
        hostingView.setContentHuggingPriority(.required, for: .horizontal)
        hostingView.setContentCompressionResistancePriority(.required, for: .vertical)
        hostingView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class HostingView<Content: View>: UIView {
    private let rootViewHostingController: UIHostingController<Content>

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
        self.setupController()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupController() {
        rootViewHostingController.view.backgroundColor = .clear
        addSubview(rootViewHostingController.view)

        rootViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        rootViewHostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rootViewHostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rootViewHostingController.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rootViewHostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        rootViewHostingController.view.setContentHuggingPriority(.required, for: .vertical)
        rootViewHostingController.view.setContentHuggingPriority(.required, for: .horizontal)
        rootViewHostingController.view.setContentCompressionResistancePriority(.required, for: .vertical)
        rootViewHostingController.view.setContentCompressionResistancePriority(.required, for: .horizontal)
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
        cell.rootView = CellView(content: "Title Title Title ", numberOfRepetitions: .random(in: 1..<20))
        return cell
    }
}
