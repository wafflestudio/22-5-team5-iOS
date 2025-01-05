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
                
                
                Color.backgourndSpaceColor
                    .frame(height: 10)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 20)
                    
                    HStack(spacing: 0) {
                        Text("카테고리 인기글")
                            .font(.system(size: 22, weight: .black))
                            .foregroundStyle(Color.primaryLabelColor)
                        
                        Spacer()
                    }
                    .padding(.leading, 5)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 12)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            Spacer()
                                .frame(width: 20)
                            ForEach(viewModel.categoryList, id: \.self) { category in
                                categoryButton(category: category, isSelected: viewModel.selectedCategory == category)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
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
    
    @ViewBuilder func categoryButton(category: String, isSelected: Bool) -> some View {
        Button(action: {
            viewModel.selectedCategory = category
        }) {
            HStack(spacing: 3) {
                Image(systemName: viewModel.categoryIcons[category]!)
                    .font(.system(size: 14))
                Text(category)
                    .font(.system(size: 14, weight: isSelected ? .bold : .light))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(isSelected ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(isSelected ? Color.clear : Color.middleDotColor, lineWidth: 1)
                    )
                    .shadow(color: isSelected ? Color.clear : Color.black.opacity(0.13), radius: 3, x: 0, y: 3)
            )
        }
        .padding(.top, 2)
        .padding(.bottom, 20)
            
    }
    
}


#Preview {
    HomeView()
}

extension Color {
    static let backgourndSpaceColor = Color.init(red: 241/255, green: 241/255, blue: 241/255)
}
