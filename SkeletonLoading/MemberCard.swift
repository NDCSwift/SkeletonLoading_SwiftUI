//
        //
    //  Project: SkeletonLoading
    //  File: MemberCard.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import SwiftUI

struct MemberCard: View {
    let member: Member
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                // .quaternary is a system adaptive color — it automatically
                // appears as a light gray in light mode and a dark gray in dark
                // mode, so no manual color scheme check is needed.
                Circle()
                    .fill(.quaternary)
                Text(member.initials)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(member.name)
                    .font(.headline)
                Text(member.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    // reservesSpace: true is critical for skeleton stability —
                    // it keeps every card the same height whether the role text
                    // wraps to 1 or 2 lines. Without it, row heights shift when
                    // real data loads, causing a jarring layout jump.
                    // CUSTOMIZE: change 2 to match the max lines you expect in your data.
                    .lineLimit(2, reservesSpace: true)
            }
        }
    }
}

#Preview {
    MemberCard(member: .placeholder)
}
