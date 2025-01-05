//
//  FocusPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct FocusPostListView: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            Text("Focus")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.primaryLabelColor)
            Rectangle()
                .frame(width: 41.5, height: 2)
                .foregroundColor(Color.primaryLabelColor)
                .offset(y: -3)
            
            Spacer()
                .frame(height: 5)
            
            HStack(spacing: 5) {
                Text("J의 주말 계획")
                    .font(.system(size: 34, weight: .black))
                
                Image(systemName: "figure.outdoor.cycle")
                    .font(.system(size: 32))
            }
            .foregroundStyle(Color.primaryLabelColor)
            
            Spacer()
                .frame(height: 10)
            
            Text("주말 나들이 갈만한 곳을 알아보세요.\n진정한 J라면 월요일부터 주말 계획을 세워야 하니까요.")
                .font(.system(size: 13, weight: .light))
                .foregroundStyle(Color.secondaryLabelColor)
                .lineSpacing(3)
            
            Spacer()
                .frame(height: 15)
            
            VStack(spacing: 0) {
                ForEach(Array(viewModel.focusPostList1Items.enumerated()), id: \.offset) { index, item in
                    HomePostListCell(index: index)
                }
            }
        }
        .padding(.horizontal, 20)
        
        Color.backgourndSpaceColor
            .frame(height: 10)
        
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            Text("Focus")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.primaryLabelColor)
            Rectangle()
                .frame(width: 41.5, height: 2)
                .foregroundColor(Color.primaryLabelColor)
                .offset(y: -3)
            
            Spacer()
                .frame(height: 5)
            
            HStack(spacing: 5) {
                Text("오후에는 커피 한 잔")
                    .font(.system(size: 34, weight: .black))
                
                Image(systemName: "cup.and.heat.waves.fill")
                    .font(.system(size: 32))
            }
            .foregroundStyle(Color.primaryLabelColor)
            
            Spacer()
                .frame(height: 10)
            
            Text("커피 한 잔의 여유를 아는 품격있는 당신.\n달달이와도 함께 할 수 있는 공간을 소개합니다.")
                .font(.system(size: 13, weight: .light))
                .foregroundStyle(Color.secondaryLabelColor)
                .lineSpacing(3)
            
            Spacer()
                .frame(height: 15)
            
            VStack(spacing: 0) {
                ForEach(Array(viewModel.focusPostList2Items.enumerated()), id: \.offset) { index, item in
                    HomePostListCell(index: index)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
