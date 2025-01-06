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
    
    var body: some View {
        ZStack {
            TabView(selection: $mainTabViewModel.selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Text("홈")
                }
                .tag(TabType.home)
                .mainTabToolbarConfigurations()
                
                
                NavigationStack {
                    FeedView()
                }
                .tabItem {
                    Text("피드")
                }
                .tag(TabType.feed)
                .mainTabToolbarConfigurations()
                
                
                Color.clear
                    .tabItem {
                        Text("글쓰기")
                    }
                    .tag(TabType.write)
                    .mainTabToolbarConfigurations()
                    .fullScreenCover(isPresented: $mainTabViewModel.isPostingViewPresent) {
                        NavigationStack {
                            //MARK: PostingView
                            PostingView(mainTabViewModel: mainTabViewModel)
                        }
                        .onAppear() {print(mainTabViewModel.isPostingViewPresent)}
                    }
                
                
                NavigationStack {
                    NotificationView(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                }
                .tabItem {
                    Text("알림")
                }
                .tag(TabType.notification)
                .mainTabToolbarConfigurations()
                
                
                NavigationStack {
                    // statView
                }
                .tabItem {
                    Text("stat")
                }
                .tag(TabType.stat)
                .mainTabToolbarConfigurations()
            }
            .tint(.black)
            .onChange(of: mainTabViewModel.selectedTab) { oldValue, newValue in
                if newValue == .write {
                    mainTabViewModel.toggleIsPostingViewPresent()
                    mainTabViewModel.setSelectedTab(to: oldValue)
                }
            }
            
            // MARK: NotificationTypeSheet
            NotificationTypeSheet(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
            
        }
    }
}


//TabType case 이름은 추후 수정 및 확정
enum TabType: String {
    case home
    case feed
    case write
    case notification
    case stat
}

extension View {
    func mainTabToolbarConfigurations() -> some View {
        self
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.white, for: .navigationBar)
    }
}
