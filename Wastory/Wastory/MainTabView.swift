//
//  ContentView.swift
//  Wastory
//
//  Created by 중워니 on 12/24/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: TabType = .home
    
    var body: some View {
        
        //TODO: 각 tabItem 이미지
        TabView(selection: $selectedTab) {
            Group {
                NavigationStack {
                    // homeView
                }
                .tabItem {
                    Text("홈")
                }
                .tag(TabType.home)
                
                
                NavigationStack {
                    // feedView
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
                    // notificationView
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
