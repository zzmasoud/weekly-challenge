//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating = false
    @State private var indicatorVOffset: Double = 0
    
    @State private var textIsAnimating = false
    @State private var textAnimation = TextAnimation()
    
    struct TextAnimation {
        var verticalOffset: Double = 0
        var opacity: Double = 0
    }
    
    var body: some View {
        return VStack {
            Spacer()
            content
                .padding(10)
                .background(.red)
                .onTapGesture { 
                    isAnimating.toggle()
                    textIsAnimating.toggle()
                }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
    }
    
    private var content: some View {
        VStack(spacing: 4) {
            text
            indicator
        }
    }
    
    private var text: some View {
        Text("Swipe to open")
            .font(.subheadline)
            .foregroundColor(.white)
            .keyframeAnimator(
                initialValue: textAnimation,
                trigger: textIsAnimating,
                content: { view, value in
                    view
                        .offset(y: value.verticalOffset)
                        .opacity(value.opacity)
                },
                keyframes: { value in
                    KeyframeTrack(\.verticalOffset) {
                        CubicKeyframe(-15, duration: 0.5)
                        CubicKeyframe(-20, duration: 0.5)
                    }
                    KeyframeTrack(\.opacity) {
                        CubicKeyframe(1, duration: 0.5)
                    }
                }
            )
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.white)
            .frame(width: 150, height: 5)
            .keyframeAnimator(
                initialValue: indicatorVOffset,
                trigger: isAnimating,
                content: { view, value in
                    view.offset(y: value)
                },
                keyframes: { value in
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
