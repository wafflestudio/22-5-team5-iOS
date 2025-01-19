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
    
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $mainTabViewModel.selectedTab) {
                    
                    HomeView(mainTabViewModel: mainTabViewModel)
                        .tabItem {
                            Text("홈")
                        }
                        .tag(TabType.home)
                    
                    
                    FeedView(mainTabViewModel: mainTabViewModel)
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
                    
                    
                    NotificationView(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                        .tabItem {
                            Text("알림")
                        }
                        .tag(TabType.notification)
                    
                    
                    //MyBlogView로 추후 연결
                    MyBlogView()
                        .tabItem {
                            Text("내블로그")
                        }
                        .tag(TabType.myBlog)
                    
                }
                .tint(.black)
                .background(Color.white)
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
                
                
                
            } //ZStack
        }// NavStack
        
    } //body
}

struct mainTabToolBarTrailingButtons: View {
    @Bindable var mainTabViewModel: MainTabViewModel
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            contentViewModel.navigateToSearchViewButton() {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25, weight: .thin))
            }
            
            Button {
                mainTabViewModel.toggleIsBlogSheetPresent()
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
        .frame(height: 44)
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

