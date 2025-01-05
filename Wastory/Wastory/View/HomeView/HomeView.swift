//
//  HomeView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: 오늘의 티스토리 PageTabView
                TodaysWastoryPageTabView(viewModel: viewModel)
                
                // MARK: 오늘의 티스토리 ListView
                TodaysWastoryListView(viewModel: viewModel)
                
            } //VStack
        } //ScrollView
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundStyle(Color.primaryLabelColor)
                        .frame(width: 48, height: 2)
                        .offset(x: 13, y: 4)
                    
                    Text("wastory")
                        .foregroundStyle(Color.primaryLabelColor)
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.horizontal, 5)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Text(Image(systemName: "magnifyingglass"))
                }
            }
        } //toolbar
        
    }
    
}


#Preview {
    HomeView()
}
