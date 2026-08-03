//
        //
    //  Project: SkeletonLoading
    //  File: ContentView.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var members: [Member] = []

    // Minimum time the skeleton stays visible even if the fetch returns instantly.
    // Without this, a very fast network causes the skeleton to flash for <100 ms —
    // which looks like a glitch rather than intentional loading feedback.
    // CUSTOMIZE: lower to 0 to disable the floor, raise to 800+ for slower networks.
    private let minimumSkeleton = Duration.milliseconds(400)

    var body: some View {
        NavigationStack {
            // Group is required here so both branches share the same view identity
            // inside NavigationStack, which allows .transition(.opacity) to animate
            // the swap instead of performing an instant replace.
            Group {
                if isLoading {
                    roster(Member.placeholders)
                        .skeleton(isLoading: true)
                        // Collapse all the placeholder rows into a single accessibility
                        // element so VoiceOver announces one clear loading message
                        // rather than reading out every dummy name.
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Loading team")
                        .transition(.opacity)
                } else {
                    roster(members)
                        .transition(.opacity)
                }
            }
            .navigationTitle("Roster")
            .navigationDestination(for: Member.self) { MemberDetail(member: $0) }
            .toolbar {
                Button("Reload") {
                    Task { await load() }
                }
            }
        }
        // .task automatically cancels when the view disappears, making it safer
        // than manually managing a Task in .onAppear.
        .task { await load() }
        .padding()
    }
    
    private func load() async {
        isLoading = true
        let started = ContinuousClock.now
        
        // CUSTOMIZE: replace this simulated delay with your real data fetch,
        // e.g. members = try await memberService.fetchTeam()
        try? await Task.sleep(for: .milliseconds(3000))
        members = Member.team
        
        // Enforce the minimum display time before hiding the skeleton.
        await holdSkeleton(since: started)
        isLoading = false
    }
    
    // Calculates any remaining time needed to meet minimumSkeleton and sleeps for it.
    // If the fetch already took longer than minimumSkeleton, this returns immediately.
    private func holdSkeleton(since started: ContinuousClock.Instant) async {
        // ContinuousClock is the right clock for measuring elapsed wall time —
        // it advances even when the device is asleep, unlike SuspendingClock.
        let shown = ContinuousClock.now - started
        guard shown < minimumSkeleton else { return }
        try? await Task.sleep(for: minimumSkeleton - shown)
    }
    
    // Extracted into a helper so body stays readable. Both the skeleton and real
    // branches call the same function — only the data differs, keeping layout
    // identical and preventing any structural shift when loading completes.
    private func roster(_ members: [Member]) -> some View {
        List {
            Section {
                ForEach(isLoading ? Member.placeholders : members) { member in
                    NavigationLink(value: member) {
                        MemberCard(member: member)
                    }
                }
            } header: {
                // unredacted() ensures the section header is never swallowed by
                // the .skeleton modifier — it always reads "Team" even while loading.
                Text("Team").unredacted()
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
