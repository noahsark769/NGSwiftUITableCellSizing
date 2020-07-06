//
//  ContentView.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/6/20.
//

import SwiftUI

struct CellView: View {
    let content: String
    let numberOfRepetitions: Int

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Rectangle()
                .fill(Color(.opaqueSeparator))
                .frame(width: 2)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.content)
                    .lineLimit(1)
                Text(String(repeating: content + " ", count: numberOfRepetitions))
                    .font(.caption)
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(nil)
                    .layoutPriority(1)
            }
            .padding([.top, .bottom], 10)
            Spacer()
        }
        .padding([.leading, .trailing], 10)
        .edgesIgnoringSafeArea(.bottom)
        .fixedSize(horizontal: false, vertical: true)
    }
}
