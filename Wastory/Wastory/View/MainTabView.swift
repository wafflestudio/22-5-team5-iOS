//
//  MainTabView.swift
//  Wastory
//
//  Created by 중워니 on 12/24/24.
//

import SwiftUI

struct MainTabView: View {
    @State var mainTabViewModel: MainTabViewModel = MainTabViewModel()
    @State var notificationViewModel: NotificationViewModel = NotificationViewModel()
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $mainTabViewModel.selectedTab) {
                NavigationStack {
                    HomeView(mainTabViewModel: mainTabViewModel)
                        .mainTabToolbarConfigurations(with: $mainTabViewModel, contentViewModel: contentViewModel)
                }
                .tabItem {
                    Text("홈")
                }
                .tag(TabType.home)
                
                
                NavigationStack {
                    FeedView()
                        .mainTabToolbarConfigurations(with: $mainTabViewModel, contentViewModel: contentViewModel)
                }
                .tabItem {
                    Text("피드")
                }
                .tag(TabType.feed)
                
                
                Color.clear
                    .tabItem {
                        Text("글쓰기")
                    }
                    .tag(TabType.write)
                    .fullScreenCover(isPresented: $mainTabViewModel.isPostingViewPresent) {
                        NavigationStack {
                            //MARK: PostingView
                            PostingView(mainTabViewModel: mainTabViewModel)
                        }
                    }
                
                
                NavigationStack {
                    NotificationView(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                        .mainTabToolbarConfigurations(with: $mainTabViewModel, contentViewModel: contentViewModel)
                }
                .tabItem {
                    Text("알림")
                }
                .tag(TabType.notification)
                
                
                NavigationStack {
                    //MyBlogView로 추후 연결
                    MyBlogView()
                        .mainTabToolbarConfigurations(with: $mainTabViewModel, contentViewModel: contentViewModel)
                }
                .tabItem {
                    Text("내블로그")
                }
                .tag(TabType.myBlog)
            }
            .tint(.black)
            .onChange(of: mainTabViewModel.selectedTab) { oldValue, newValue in
                if newValue == .write {
                    mainTabViewModel.toggleIsPostingViewPresent()
                    mainTabViewModel.setSelectedTab(to: oldValue)
                }
            }
            
            // MARK: BlogSheet
            BlogSheet(mainTabViewModel: mainTabViewModel)
            
            // MARK: NotificationTypeSheet
            NotificationTypeSheet(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
            
            
            
            // MARK: ContentNavigationStack()
            ContentNavigationStack()
        } //ZStack
    
        
    } //body
}

extension View {
    func mainTabToolbarConfigurations(with mainTabViewModel: Binding<MainTabViewModel>, contentViewModel: ContentViewModel) -> some View {
        self
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        contentViewModel.toggleIsSearchViewPresented()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mainTabViewModel.wrappedValue.toggleIsBlogSheetPresent()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.mainWBackgroundGray)
                                .frame(width: 32, height: 32)
                            VStack(spacing: 2) {
                                HStack(spacing: 4) {
                                    MainWCircleUnit()
                                    MainWCircleUnit()
                                    MainWCircleUnit()
                                }
                                HStack(spacing: 4) {
                                    MainWCircleUnit()
                                    MainWCircleUnit()
                                    MainWCircleUnit()
                                }
                                HStack(spacing: 4) {
                                    MainWCircleUnit()
                                    MainWCircleUnit()
                                }
                            }
                        }
                    }
                }
            }
    }
}


//TabType case 이름은 추후 수정 및 확정
enum TabType: String {
    case home
    case feed
    case write
    case notification
    case myBlog
}

