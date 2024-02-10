//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Spacer()
            Button("Animate", action: { isAnimating.toggle() })
            content
                .offset(y: isAnimating ? -10 : 0)
                .animation(.bouncy(extraBounce: 0.25), value: isAnimating)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
    }
    
    private var content: some View {
        VStack {
            text
            indicator
        }
    }
    
    private var text: some View {
        Text("Swipe to open")
            .font(.subheadline)
            .foregroundColor(.white)
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.white)
            .frame(width: 150, height: 5)
    }
}

#Preview {
    ContentView()
}
