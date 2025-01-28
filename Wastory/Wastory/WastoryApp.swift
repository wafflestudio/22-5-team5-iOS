//
//  WastoryApp.swift
//  Wastory
//
//  Created by 중워니 on 12/24/24.
//

import SwiftUI

@main
struct WastoryApp: App {
    @AppStorage("userID") private var userID: String = ""
    @AppStorage("userPW") private var userPW: String = ""
    @State private var isLoading: Bool = true
    
    @State var userInfoRepository = UserInfoRepository.shared
    
//    @State private var contentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            Task {
                                await UserInfoRepository.shared.loadUserInfo(userID: userID, userPW: userPW)
                                self.isLoading = false
                            }
                        }
                    }
            }
            else {
                if UserInfoRepository.shared.isUserActive() == false {
                    NavigationStack {
                        SignTypeView()
                            .navigationDestination(isPresented: $userInfoRepository.needAddressName) {
                                SignUpStep5AddressView()
                            }
                    }
                }
                else {
                    MainTabView()
//                        .environment(\.contentViewModel, contentViewModel)
                }
            }
        }
    }
}
