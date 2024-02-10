//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            content
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
