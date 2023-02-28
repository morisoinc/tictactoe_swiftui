//
//  ContentView.swift
//  TicTacToe SwiftUI
//
//  Created by Mauricio Fontana on 28/02/23.
//

import SwiftUI

let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
]

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.teal).opacity(0.5)
                                .frame(
                                    width: geometry.size.width / 3 - 16
                                )
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.all, 16)
                Spacer()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
