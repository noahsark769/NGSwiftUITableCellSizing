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
        self.tableView.register(HostingCell<ExampleView>.self, forCellReuseIdentifier: "HostingCell<ExampleView>")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<ExampleView>", for: indexPath) as! HostingCell<ExampleView>
        cell.set(rootView: ExampleView(), parentController: self)
        return cell
    }

    override func viewSafeAreaInsetsDidChange() {
        print("changed")
    }
}

struct ExampleView: View {
    var body: some View {

        Text("Some Text")
            .font(.title)
            .background(
                GeometryReader { proxy in
                    let _ = inspect(proxy: proxy)
                    Color.clear
                }
            )
            .ignoresSafeArea(.keyboard)
    }


    func inspect(proxy: GeometryProxy) -> Void {
        if proxy.safeAreaInsets.bottom != 0 {
            dump(proxy.safeAreaInsets.bottom)
            // dump(proxy.size)
        }
    }
}
