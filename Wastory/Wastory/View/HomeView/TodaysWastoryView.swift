//
//  TodaysWastoryView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct TodaysWastoryView: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 오늘의 티스토리
            TabView(selection: $viewModel.todaysWastoryIndex) {
                ForEach(viewModel.displayedTodaysWastoryItems.indices, id: \.self) { index in
                    TodaysWastoryCell()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: viewModel.todaysWastoryIndex) { oldIndex, newIndex in
                viewModel.setNextTodaysWastoryIndex(with: newIndex)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            // MARK: 오늘의 티스토리 index indicator
            HStack(spacing: 8) {
                ForEach(viewModel.displayedTodaysWastoryItems.indices, id: \.self) { index in
                    viewModel.indexIndicator(for: index)
                }
            }
            .animation(.easeInOut, value: viewModel.todaysWastoryIndex)
        }
    }
}
