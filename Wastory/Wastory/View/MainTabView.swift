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
            //TODO: 각 tabItem 이미지
            TabView(selection: $mainTabViewModel.selectedTab) {
                Group {
                    NavigationStack {
                        // homeView
                    }
                    .tabItem {
                        Text("홈")
                    }
                    .tag(TabType.home)
                    
                    
                    NavigationStack {
                        FeedView()
                    }
                    .tabItem {
                        Text("피드")
                    }
                    .tag(TabType.feed)
                    
                    
                    NavigationStack {
                        // writeView
                    }
                    .tabItem {
                        Text("글쓰기")
                    }
                    .tag(TabType.write)
                    
                    
                    NavigationStack {
                        NotificationView(viewModel: notificationViewModel, mainTabViewModel: mainTabViewModel)
                    }
                    .tabItem {
                        Text("알림")
                    }
                    .tag(TabType.notification)
                    
                    
                    NavigationStack {
                        // statView
                    }
                    .tabItem {
                        Text("stat")
                    }
                    .tag(TabType.stat)
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .navigationBar)
            }
            .tint(.black)
            
            
            //MARK: NotificationTypeSheet
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
