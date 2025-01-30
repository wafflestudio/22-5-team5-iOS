//
//  TokenManager.swift
//  Wastory
//
//  Created by mujigae on 1/30/25.
//

import SwiftUI
import Combine

@Observable
class TokenManager {
    private var refreshTimer: AnyCancellable?
    
    init() {
        startRefreshTimer()
    }
    
    private func startRefreshTimer() {
        // MARK: 9분(540초) 간격으로 타이머 설정
        refreshTimer = Timer.publish(every: 540, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.refreshTokens()
            }
    }
    
    func refreshTokens() {
        Task {
            do {
                let response = try await NetworkRepository.shared.refreshTokens()
                DispatchQueue.main.async {
                    NetworkConfiguration.accessToken = response.access_token
                    NetworkConfiguration.refreshToken = response.refresh_token
                }
                print("Refresh tokens success!")
            } catch {
                print("Token refreshing error: \(error)")
            }
        }
    }
    
    deinit {
        refreshTimer?.cancel()
    }
}
