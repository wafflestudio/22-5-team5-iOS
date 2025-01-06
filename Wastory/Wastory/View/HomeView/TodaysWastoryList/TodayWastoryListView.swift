//
//  TodayWastoryListView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct TodaysWastoryListView: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(Array(viewModel.todaysWastoryListItems.enumerated()), id: \.offset) { index, item in
                TodaysWastoryListCell(index: index + 1)
            }
        }
        .background(Color.white)
    }
}
