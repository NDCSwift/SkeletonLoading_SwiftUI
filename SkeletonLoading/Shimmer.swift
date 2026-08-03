//
        //
    //  Project: SkeletonLoading
    //  File: Shimmer.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

import SwiftUI

struct Shimmer: ViewModifier {
    // phase drives the horizontal position of the highlight sweep.
    // Starting at -1 places the gradient fully off-screen to the left.
    @State private var phase: CGFloat = -1

    // Always respect the system reduce-motion preference — users with vestibular
    // disorders can experience nausea from looping animations. When this is true
    // we simply skip the shimmer and show the static redacted placeholders.
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    func body(content: Content) -> some View {
        if reduceMotion {
            content
        } else {
            content
                .overlay {
                    GeometryReader { proxy in
                        // The gradient is 55% of the content width — wide enough
                        // to look like a smooth highlight sweep, narrow enough to
                        // avoid looking like a full-view flash.
                        // CUSTOMIZE: lower the multiplier (e.g. 0.3) for a tighter
                        // beam, raise it (e.g. 0.8) for a broader wash.
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.55), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: proxy.size.width * 0.55)
                        // phase * width moves the gradient from fully left (-width)
                        // to fully right (+2*width) over the animation cycle.
                        .offset(x: proxy.size.width * phase)
                    }
                    // mask clips the gradient to exactly the shape of the redacted
                    // placeholders, so the shimmer only appears where content would
                    // be — not over the background or padding areas.
                    .mask { content }
                    .allowsHitTesting(false)
                }
                .onAppear {
                    // CUSTOMIZE: change duration for faster (e.g. 0.7) or slower
                    // (e.g. 1.8) sweeps. autoreverses: true makes it sweep right
                    // then back left; set to false and keep phase at 2.0 for a
                    // continuous one-directional left-to-right loop.
                    withAnimation(.linear(duration: 1.1).repeatForever(autoreverses: true)) {
                        phase = 2.0
                    }
                }
        }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(Shimmer())
    }
}
