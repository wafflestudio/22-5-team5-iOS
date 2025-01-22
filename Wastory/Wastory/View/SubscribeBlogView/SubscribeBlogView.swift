//
//  SubscribeBlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/22/25.
//

import SwiftUI

struct SubscribeBlogView: View {
    let subscribeType: SubscribeType
    
    @State var viewModel = SubscribeBlogViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 20)
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    // MARK: 화면 상단 구성 요소
                    HStack(alignment: .top) {
                        //Navbar title
                        Text(viewModel.isSubscribing() ? "구독중" : "구독자")
                            .font(.system(size: 34, weight: .medium))
                        
                        Spacer()
                            .frame(width: 4)
                        
                        //comment count
                        Text("\(viewModel.totalCount ?? 0)")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                    
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    
                    // MARK: 댓글List
                    ForEach(viewModel.blogs) { blog in
                        SearchedBlogCell(blog: blog)
                    }
                }
            }
        }
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : (viewModel.isSubscribing() ? "구독중" : "구독자"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
}



enum SubscribeType: String {
    case subscribing
    case subscriber
}
