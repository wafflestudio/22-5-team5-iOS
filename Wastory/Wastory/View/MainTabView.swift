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
                            Image(mainTabViewModel.selectedTab == TabType.home ? "homeW.fill" : "homeW")
                        }
                        .tag(TabType.home)
                    
                    
                    FeedView(mainTabViewModel: mainTabViewModel)
                        .tabItem {
                            Image(mainTabViewModel.selectedTab == TabType.feed ? "feed.fill" : "feed")
                        }
                        .tag(TabType.feed)
                    
                    
                    Color.clear
                        .tabItem {
                            Image("article")
                        }
                        .tag(TabType.write)
                        .fullScreenCover(isPresented: $mainTabViewModel.isArticleViewPresent) {
                            NavigationStack {
                                // MARK: ArticleView
                                ArticleView(mainTabViewModel: mainTabViewModel)
                            }
                        }
                    
                    
                    NotificationView(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                        .tabItem {
                            Image(mainTabViewModel.selectedTab == TabType.notification ? "bell.fill" : "bell")
                        }
                        .tag(TabType.notification)
                    
                    
                    //MyBlogView로 추후 연결
                    BlogView(blogID: UserInfoRepository.shared.getBlogID(), isMainTab: true)
                        .tabItem {
                            Image(mainTabViewModel.selectedTab == TabType.myBlog ? "myW.edge" : "myW")
                        }
                        .tag(TabType.myBlog)
                }
                .tint(.black)
                .background(Color.white)
                .onChange(of: mainTabViewModel.selectedTab) { oldValue, newValue in
                    if newValue == .write {
                        mainTabViewModel.toggleIsArticleViewPresent()
                        mainTabViewModel.setSelectedTab(to: oldValue)
                    }
                }
                
                VStack() {
                    Spacer()
                    HStack() {
                        Spacer()
                        KFImageWithoutDefault(imageURL: UserInfoRepository.shared.getBlogMainImageURL())
                            .frame(width: 29, height: 29)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.bottom, 9.5)
                            .offset(x: -UIScreen.main.bounds.width/10 + 14.25)
                    }
                }
                
                // MARK: BlogSheet
                BlogSheet(mainTabViewModel: mainTabViewModel)
                
                // MARK: NotificationTypeSheet
                NotificationTypeSheet(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                
                
                
            } //ZStack
        }// NavStack
        .onAppear {
            Task {
                await mainTabViewModel.setIsNotificationUnread()
            }
        }
        
    } //body
}

struct mainTabToolBarTrailingButtons: View {
    @Bindable var mainTabViewModel: MainTabViewModel
//    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            NavigateToSearchViewButton() {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25, weight: .thin))
            }
            
            Button {
                mainTabViewModel.toggleIsBlogSheetPresent()
            } label: {
                KFImageWithDefaultIcon(imageURL: UserInfoRepository.shared.getBlogMainImageURL())
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
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

#Preview {
    MainTabView()
}
