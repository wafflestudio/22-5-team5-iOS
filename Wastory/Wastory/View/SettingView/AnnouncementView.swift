//
//  AnnouncementView.swift
//  Wastory
//
//  Created by mujigae on 1/31/25.
//

import SwiftUI

struct AnnouncementView: View {
    @State private var viewModel = AnnouncementViewModel()
    
    var body: some View {
        NavigationStack {
            // Announcement like feeds
        }
        .navigationTitle("공지사항")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
    }
}
