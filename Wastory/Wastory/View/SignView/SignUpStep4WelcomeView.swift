//
//  SignUpStep4WelcomeView.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import SwiftUI

struct SignUpStep4WelcomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("환영합니다!")
                    .font(.system(size: 24))
                    .padding(.top, 150)
                Spacer()
                    .frame(height: 12)
                
                Text("와스토리 계정 가입이 완료되었습니다.")
                    .foregroundStyle(Color.promptLabelColor)
                    .font(.system(size: 12))
                Spacer()
                    .frame(height: 3)
                Text("와스토리를 즐겨 보세요!")
                    .foregroundStyle(Color.promptLabelColor)
                    .font(.system(size: 12))
                Spacer()
                    .frame(height: 30)
                
                Text(UserInfoRepository.shared.getUserID())
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Button {
                    Task {
                        await UserInfoRepository.shared.loadUserInfo(userID: UserInfoRepository.shared.getUserID(), userPW: UserInfoRepository.shared.getUserPW())
                    }
                } label: {
                    Text("시작하기")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(Color.kakaoYellow)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 150)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
    }
}
