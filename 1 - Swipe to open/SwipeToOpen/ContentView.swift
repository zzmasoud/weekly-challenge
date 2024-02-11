//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ContentView: View {
    
    @State private var indicatorVOffset: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            content
                .padding(10)
                .background(.red)
                .onTapGesture { indicatorVOffset = -10 }
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
            .keyframeAnimator(initialValue: indicatorVOffset, repeating: true, content: { view, value in
                view.offset(y: value)
            }, keyframes: { value in
                KeyframeTrack {
                    CubicKeyframe(-10, duration: 0.5)
                    CubicKeyframe(0, duration: 1.5)
                }
            })
    }
}

#Preview {
    ContentView()
}
