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

struct ComplicatedCellView: View {
    let value: Int
    @State var isColorInverted = false

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle().fill(isColorInverted ? Color.red : Color.green).frame(width: 50, height: 50)
                    Rectangle().fill(isColorInverted ? Color.green : Color.red).frame(width: 50, height: 50)
                    Spacer()
                }.frame(minHeight: 150).animation(.spring())
                Rectangle().fill(Color.blue).frame(minWidth: 100)
                VStack {
                    Text(String(repeating: "Value ", count: value % 40) + "\(value % 40)")
                        .lineLimit(nil)
                        .layoutPriority(1)
                    Rectangle().fill(Color.red).frame(width: 50, height: 50)
                    Spacer()
                }
            }
            Button(action: {
                self.isColorInverted.toggle()
            }, label: {
                Text("Tap me!")
            }).padding(.bottom, 5)
        }
        .border(Color.yellow)
        .padding()
        .frame(minHeight: 0, maxHeight: .infinity)
        .border(Color.purple)
        .edgesIgnoringSafeArea(.all)
        .fixedSize(horizontal: false, vertical: true)
    }
}
