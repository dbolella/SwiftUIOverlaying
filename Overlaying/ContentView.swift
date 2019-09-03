//
//  ContentView.swift
//  Overlaying
//
//  Created by Daniel Bolella on 9/3/19.
//  Copyright © 2019 Daniel Bolella. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State var showOverLay = false
    @State var grow = false
    @State var showOverlay = false
    @State var curColor = Color.red
    
    let colors = [Color.blue, Color.red, Color.green, Color.yellow]
    
    var body: some View {
        Text("Hello World")
            .frame(width: 100, height: 100)
            .background(curColor)
            .onTapGesture { self.showOverlay.toggle() }
            .overlay(
                VStack {
                    if self.showOverlay {
                        ZStack {
                            ForEach(0 ..< 4) { item in
                                ArcSelectionView(isShowing: self.grow, arcPosition: (0.25 * Double(item + 1)), color: self.colors[item])
                                    .onTapGesture {
                                        self.curColor = self.colors[item]
                                        self.showOverlay.toggle()
                                }
                            }
                        }
                        .rotationEffect(.degrees(self.grow ? 0 : 180))
                        .animation(.linear(duration: 0.5))
                        .onAppear { self.grow.toggle() }
                        .onDisappear { self.grow.toggle() }
                    } else {
                        EmptyView()
                    }
                }
        )
    }
}

struct ArcSelectionView: View {
    var isShowing = false
    var arcPosition : Double
    var color : Color
    
    var body: some View {
        Circle()
            .trim(from: isShowing ? CGFloat(arcPosition - 0.25) : CGFloat(arcPosition), to: CGFloat(arcPosition))
            .stroke(color, lineWidth: 30)
            .frame(width: 300, height: 300)
            .animation(.linear(duration: 0.4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
