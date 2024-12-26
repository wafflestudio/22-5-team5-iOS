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
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isLoading = false
                        }
                    }
            }
            else {
                if userID.isEmpty {
                    SignInView()
                }
                else {
                    // 현재는 ID, PW가 있을 경우 자동 로그인이지만 나중에는 PW를 DB에 있는 PW와 확인하는 절차가 필요
                    MainTabView()
                }
            }
        }
    }
}
