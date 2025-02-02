//
//  DeepLinkHandler.swift
//  Wastory
//
//  Created by mujigae on 1/26/25.
//

import Foundation
import SwiftUI

@MainActor
struct DeepLinkHandler {
    static let shared = DeepLinkHandler()    // 싱글톤 인스턴스
    
    @AppStorage("didKakaoLogin") private var didKakaoLogin: Bool = false
    
    func authHandler(url: URL) async {
        guard url.scheme == "wastory",
              url.host == "authSuccess",
              let accessToken = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "access_token" })?.value,
              let refreshToken = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "refresh_token" })?.value
        else {
            print("Error: Failed to fetch jwt token for kakao users")
            return
        }
        Task {
            NetworkConfiguration.accessToken = accessToken
            NetworkConfiguration.refreshToken = refreshToken
            didKakaoLogin = true
            await UserInfoRepository.shared.loadKakaoUserInfo()
        }
    }
}
