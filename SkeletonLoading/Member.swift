//
        //
    //  Project: SkeletonLoading
    //  File: Member.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import Foundation

struct Member: Identifiable, Hashable {
    let id: Int
    let initials: String
    let name: String
    let role: String
}


extension Member {
    // MARK: - Placeholder Data

    // The placeholder text length is intentional: redacted(reason: .placeholder)
    // sizes its gray bars to match the real text's bounding box. Using short
    // dummy text like "Name" would produce a tiny bar that snaps to a larger
    // size when real data loads, causing a visible layout jump.
    // CUSTOMIZE: adjust these strings to match the average length of your real data.
    static let placeholder = Member(
        id: -1,
        initials: "JD",
        name: "Jane Doe Placement",
        role: "Senior iOS dev, sized to match a real role"
    )
    
    // Negative IDs guarantee placeholders can never collide with real server IDs.
    // CUSTOMIZE: change the count (0..<6) to control how many skeleton rows appear.
    // Matching it to your expected real-data count avoids a row-count jump on load.
    static let placeholders: [Member] = (0..<6).map { index in
        Member(id: -index - 1, initials: placeholder.initials, name: placeholder.name, role: placeholder.role)
    }
    
    // MARK: - Real Data

    // In a real app, replace this static array with an async fetch from your API
    // or SwiftData store. The load() function in ContentView is the right place
    // to make that call — the skeleton/real-data swap logic stays the same.
    static let team: [Member] = [
        Member(id: 1, initials: "JD", name: "Jane Doe", role: "Senior iOS Dev"),
        Member(id: 2, initials: "MR", name: "Marco Rivers", role: "Design Lead"),
        Member(id: 3, initials: "AD", name: "Anthony Davis", role: "Food Taster"),
        Member(id: 4, initials: "BK", name: "Burger King", role: "McDonalds Rival"),
        Member(id: 5, initials: "NP", name: "Noah Problem", role: "Director"),
        Member(id: 6, initials: "MD", name: "Matt Demolisher", role: "Engineer"),
    ]
}
