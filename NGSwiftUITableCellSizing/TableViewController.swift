//
//  TableViewController.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/6/20.
//

import Foundation
import UIKit
import SwiftUI

final class TableViewController: UITableViewController {
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.tableView.register(HostingCell<Text>.self, forCellReuseIdentifier: "HostingCell<Text>")
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        300
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<Text>", for: indexPath) as! HostingCell<Text>
        cell.set(rootView: Text("Hi"), parentController: self)
        return cell
    }
}
