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
        self.tableView.register(HostingCell<CellView>.self, forCellReuseIdentifier: "HostingCell<CellView>")
        self.tableView.register(HostingCell<ComplicatedCellView>.self, forCellReuseIdentifier: "HostingCell<ComplicatedCellView>")
        self.tableView.separatorStyle = .none
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
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 6 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<ComplicatedCellView>", for: indexPath) as! HostingCell<ComplicatedCellView>
            cell.set(rootView: ComplicatedCellView(value: indexPath.row), parentController: self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<CellView>", for: indexPath) as! HostingCell<CellView>
            cell.set(rootView: CellView(content: "Title Title Title ", numberOfRepetitions: indexPath.row % 20 + 1), parentController: self)
            return cell
        }
    }
}
