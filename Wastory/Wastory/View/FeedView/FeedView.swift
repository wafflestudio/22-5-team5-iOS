//
//  FeedView.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

//"피드" View에 구독 중인 블로그의 최신 글을 표시
struct FeedView: View {
    @Bindable var mainTabViewModel: MainTabViewModel
    @State var viewModel = FeedViewModel()
    @Environment(\.contentViewModel) var contentViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: NavBar
            VStack(spacing: 0) {
                ZStack {
                    if !viewModel.getIsNavTitleHidden() {
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Text("피드")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Spacer()
                        }
                    }
                    
                    
                    // 공통버튼들
                    mainTabToolBarTrailingButtons(mainTabViewModel: mainTabViewModel)
                }
                .padding(.horizontal, 20)
                .frame(height: 44)
                
                if viewModel.getIsScrolled() {
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                        .frame(height: 1)
                        .offset(y: -1)
                }
            }
            
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                            viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                        }
                }
                .frame(height: 0)
                
                // MARK: 화면 상단 구성 요소
                HStack {
                    //Navbar title
                    Text("피드")
                        .font(.system(size: 34, weight: .medium))
                        .padding(.leading)
                    
                    Spacer()
                    
                    // 구독중
                    NavigationLink(destination: SubscribeBlogView(subscribeType: .subscribing)) {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text("구독중")
                                .font(.system(size: 13, weight: .light))
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 4)
                            
                            Text("\(viewModel.subscribingCount)")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        .padding(.trailing, 12)
                    }
                    
                    // 구독자
                    NavigationLink(destination: SubscribeBlogView(subscribeType: .subscriber)) {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text("구독자")
                                .font(.system(size: 13, weight: .light))
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 4)
                            
                            Text("\(viewModel.subscriberCount)")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                .padding(.trailing, 22)
                
                //MARK: PostList
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.posts.enumerated()), id: \.offset) { index, post in
                        BasicPostCell(post: post)
                        Divider()
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
            }
        }
        //MARK: Network
        .onAppear {
            Task {
                await viewModel.getPosts()
            }
            Task {
                await viewModel.getSubscriptionCounts()
            }
        }
        .refreshable {
            viewModel.resetPage()
            Task {
                await viewModel.getPosts()
            }
            Task {
                await viewModel.getSubscriptionCounts()
            }
        }
        
        
    }
}
