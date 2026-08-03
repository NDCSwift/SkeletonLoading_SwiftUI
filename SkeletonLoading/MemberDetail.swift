//
        //
    //  Project: SkeletonLoading
    //  File: MemberDetail.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    

import SwiftUI

struct MemberDetail: View {
    let member: Member
    var body: some View {
        VStack {
            Text(member.name)
                .font(.largeTitle)
            Text(member.role)
                .font(.title3)
        }
        .navigationTitle(member.initials)
        
    }
}

#Preview {
    MemberDetail(member: .placeholder)
}
