//
//  TableViewController.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/6/20.
//

import Foundation
import UIKit

final class TableViewController: UITableViewController {
    override init(style: UITableView.Style) {
        super.init(style: style)
//        self.tableView.register(HostingCell<CellView>.self, forCellReuseIdentifier: "HostingCell<CellView>")
        self.tableView.register(HostingCell<ComplicatedCellView>.self, forCellReuseIdentifier: "HostingCell<ComplicatedCellView>")
        self.tableView.separatorStyle = .none
        self.tableView.insetsContentViewsToSafeArea = false
        self.tableView.insetsLayoutMarginsFromSafeArea = false
//        self.tableView.contentInsetAdjustmentBehavior = .never
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addSubview(textField)
//        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row % 6 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<ComplicatedCellView>", for: indexPath) as! HostingCell<ComplicatedCellView>
            cell.set(rootView: ComplicatedCellView(value: indexPath.row), parentController: self)
            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<CellView>", for: indexPath) as! HostingCell<CellView>
//            cell.set(rootView: CellView(content: "Title Title Title ", numberOfRepetitions: indexPath.row % 20 + 1), parentController: self)
//            return cell
//        }
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("Safea area insets changing on table view. New insets: \(self.view.safeAreaInsets)")
    }
}
