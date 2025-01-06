//
//  TodaysWastoryPageTabView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct TodaysWastoryPageTabView: View {
    @Bindable var viewModel: HomeViewModel
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 오늘의 티스토리
            TabView(selection: $viewModel.todaysWastoryIndex) {
                ForEach(viewModel.displayedTodaysWastoryItems.indices, id: \.self) { index in
                    TodaysWastoryPageTabCell()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: viewModel.todaysWastoryIndex) { oldIndex, newIndex in
                viewModel.setNextTodaysWastoryIndex(with: newIndex)
                timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
            }
            .onDisappear {
                timer.upstream.connect().cancel()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .onReceive(timer) { _ in
                viewModel.autoScrollToNextPage()
            }
            
            // MARK: 오늘의 티스토리 index indicator
            HStack(spacing: 8) {
                ForEach(viewModel.displayedTodaysWastoryItems.indices, id: \.self) { index in
                    viewModel.indexIndicator(for: index)
                }
            }
            .animation(.easeInOut, value: viewModel.todaysWastoryIndex)
        }
        .background(Color.white)
    }
}
