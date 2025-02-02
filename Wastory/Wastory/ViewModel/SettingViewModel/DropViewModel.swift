//
//  DropViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import SwiftUI
import Observation

@Observable final class DropViewModel {
    @AppStorage("userID") @ObservationIgnored private var userID: String = ""
    @AppStorage("userPW") @ObservationIgnored private var userPW: String = ""
    @AppStorage("loginAutoSave") @ObservationIgnored private var loginInfoSave: Bool = false
    @AppStorage("didKakaoLogin") @ObservationIgnored private var didKakaoLogin: Bool = false
    
    var isDropAgreed: Bool = false

    func toggleDropAgreed() {
        isDropAgreed.toggle()
    }
    
    func deleteAccount() async {
        do {
            try await NetworkRepository.shared.deleteMe()
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        UserInfoRepository.shared.resetUserInfo()
        NetworkConfiguration.accessToken = ""
        NetworkConfiguration.refreshToken = ""
        userID = ""
        userPW = ""
        loginInfoSave = false
        didKakaoLogin = false
    }
}

