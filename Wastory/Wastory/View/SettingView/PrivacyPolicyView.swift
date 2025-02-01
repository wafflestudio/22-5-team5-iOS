//
//  PrivacyPolicyView.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @State private var viewModel = PrivacyPolicyViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                CustomBackButton(size: 24, weight: .regular)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            Spacer()
                .frame(height: 20)
            
            HStack(spacing: 8) {
                Text("wastory")
                    .font(.system(size: 24, weight: .regular))
                Text(viewModel.languageType == .kor ? "개인정보 처리방침" : "Privacy Policy")
                    .font(.system(size: 20, weight: .regular))
                Spacer()
                
                Button {
                    viewModel.languageType = .kor
                } label: {
                    Text("KOR")
                        .foregroundStyle(viewModel.languageType == .kor ? .black : Color.emailCautionTextGray)
                }
                Rectangle()
                    .frame(width: 0.8, height: 15)
                    .foregroundStyle(Color.emailCautionTextGray)
                Button {
                    viewModel.languageType = .eng
                } label: {
                    Text("ENG")
                        .foregroundStyle(viewModel.languageType == .eng ? .black : Color.emailCautionTextGray)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 10)
            SettingDivider(thickness: 1)
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text(viewModel.languageType == .kor ? "개인정보 처리방침" : "Privacy Policy")
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}
