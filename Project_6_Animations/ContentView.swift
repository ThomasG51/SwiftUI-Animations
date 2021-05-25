//
//  ContentView.swift
//  Project_6_Animations
//
//  Created by Thomas George on 24/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var enabled: Bool = false
    @State private var tapped: Bool = false
    @State private var dragAmount: CGSize = CGSize.zero
    
    private let letters: Array = Array("Hello SwiftUI")
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background(self.enabled ? Color.blue : Color.green)
                    .foregroundColor(Color.white)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
            .gesture(
                DragGesture()
                    .onChanged({
                        self.dragAmount = $0.translation
                    })
                    .onEnded({ _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    })
            )
        }
        
        Spacer()
        
        VStack(spacing: 10) {
            Button("Tap me") {
                self.tapped.toggle()
            }
            
            if (self.tapped) {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .animation(.default)
        
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
