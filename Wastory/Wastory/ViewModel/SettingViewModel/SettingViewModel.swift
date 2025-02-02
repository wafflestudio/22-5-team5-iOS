//
//  SettingViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import SwiftUI
import Observation

@Observable final class SettingViewModel {
    @AppStorage("userPW") @ObservationIgnored private var userPW: String = ""
    @AppStorage("didKakaoLogin") @ObservationIgnored private var didKakaoLogin: Bool = false
    
    
    func logout() {
        UserInfoRepository.shared.resetUserInfo()
        NetworkConfiguration.accessToken = ""
        NetworkConfiguration.refreshToken = ""
        userPW = ""
        didKakaoLogin = false
    }
}
