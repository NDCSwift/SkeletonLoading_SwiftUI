//
        //
    //  Project: SkeletonLoading
    //  File: View+Skeletion.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    
import SwiftUI

extension View {
    // MARK: - Skeleton Loading

    // This single modifier is the entire public API for skeleton loading.
    // Calling .skeleton(isLoading: true) on any view activates the effect;
    // .skeleton(isLoading: false) returns the original view with zero overhead.
    @ViewBuilder
    func skeleton(isLoading: Bool) -> some View {
        if isLoading {
            // redacted(reason: .placeholder) is a built-in SwiftUI modifier that
            // automatically replaces Text with rounded rectangle placeholders and
            // blurs images — no custom drawing required. The placeholder shape
            // scales to match the actual content's bounding box, which is why
            // using realistic-length placeholder text in your data model matters.
            redacted(reason: .placeholder)
                // Prevent the user from tapping list rows while skeletons are visible.
                .allowsHitTesting(false)
                // Layer the animated shimmer sweep on top of the redacted placeholders.
                .shimmer()
        } else {
            self
        }
    }
}
