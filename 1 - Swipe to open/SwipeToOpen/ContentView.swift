//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ContentView: View {
    
    struct Animation {
        var isAnimating: Bool = false
        private let duration: TimeInterval = 1.5
        var indicator = Indicator()
        var text = Text()
        
        var textDuration: TimeInterval { duration * 3/10 }
        var indicatorStartDuration: TimeInterval { textDuration }
        var indicatorEndDuration: TimeInterval { duration }
        
        struct Indicator {
            var verticalOffset: Double = 0
            var verticalOffsetDelta: Double = 10
            var startDuration: TimeInterval = 1
            var endDuration: TimeInterval = 0.5
        }

        struct Text {
            var verticalOffset: Double = 0
            var verticalOffsetDelta: Double = 20
            var opacity: Double = 0
        }
    }
    
    @State var animation = Animation()
        
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            bottomView
            
        }
        .frame(maxWidth: .infinity)
        .background(Gradient(stops: [
            .init(color: Color(#colorLiteral(red: 0.9533236623, green: 0.5445828438, blue: 0.475235939, alpha: 1)), location: 0),
            .init(color: Color(#colorLiteral(red: 0.7124326825, green: 0.2409839332, blue: 0.1112191007, alpha: 1)), location: 1)
        ]))
    }
    
    private var bottomView: some View {
        Group {
            edgeButtons
            lockScreenButton
                .padding(10)
                .onTapGesture {
                    animation.isAnimating.toggle()
                }
        }
    }
    
    private var edgeButtons: some View {
        HStack {
            Button(action: {}, label: {
                Circle()
                    .fill(.black.opacity(0.1))
                    .overlay {
                        Image(systemName: "flashlight.off.fill")
                            .resizable()
                            .scaledToFit()
                            .tint(.white)
                            .padding(14)
                    }
            })

            Spacer()
            Button(action: {}, label: {
                Circle()
                    .fill(.black.opacity(0.1))
                    .overlay {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .tint(.white)
                            .padding(14)
                    }
            })
        }
        .frame(height: 54)
        .padding(.horizontal)
    }
    
    private var lockScreenButton: some View {
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
                initialValue: animation.text,
                trigger: animation.isAnimating,
                content: { view, animation in
                    view
                        .offset(y: animation.verticalOffset)
                        .opacity(animation.opacity)
                },
                keyframes: { config in
                    KeyframeTrack(\.verticalOffset) {
                        CubicKeyframe(-config.verticalOffsetDelta * 3/4, duration: animation.textDuration)
                        CubicKeyframe(-config.verticalOffsetDelta, duration: animation.textDuration)
                    }
                    KeyframeTrack(\.opacity) {
                        CubicKeyframe(0.5, duration: animation.textDuration)
                        CubicKeyframe(1, duration: animation.textDuration)
                        CubicKeyframe(1, duration: animation.textDuration * 4)
                        CubicKeyframe(0, duration: animation.textDuration)
                    }
                }
            )
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.white)
            .frame(width: 150, height: 5)
            .keyframeAnimator(
                initialValue: animation.indicator,
                trigger: animation.isAnimating,
                content: { view, animation in
                    view.offset(y: animation.verticalOffset)
                },
                keyframes: { config in
                    KeyframeTrack(\.verticalOffset) {
                        CubicKeyframe(-config.verticalOffsetDelta, duration: animation.indicatorStartDuration)
                        CubicKeyframe(0, duration: animation.indicatorEndDuration)
                }
            })
    }
}

#Preview {
    ContentView()
}
