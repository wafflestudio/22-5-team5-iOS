//
//  VersionView.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI

struct VersionView: View {
    @State private var viewModel = VersionViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 30)
            ZStack {
                Image("myW.logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.emailCautionTextGray, lineWidth: 0.5)
                    .frame(width: 100, height: 100)
            }
            Spacer()
                .frame(height: 20)
            
            Text("와스토리")
                .font(.system(size: 20, weight: .regular))
            Spacer()
                .frame(height: 10)
            
            HStack(spacing: 10) {
                Text("현재 버전 \(viewModel.currentVersion)")
                Text("최신 버전 \(viewModel.recentVersion)")
            }
            .font(.system(size: 13, weight: .regular))
            .foregroundStyle(Color.emailCautionTextGray)
            Spacer()
                .frame(height: 30)
            
            HStack {
                Spacer()
                Text(viewModel.currentVersion == viewModel.recentVersion ? "최신 버전 사용 중" : "업데이트가 필요합니다.")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.emailCautionTextGray)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.emailCautionTextGray, lineWidth: 0.5)
            )
            .padding(.horizontal, 40)
            
            
            Spacer()
            Text("© Waffle Studio Team5")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.emailCautionTextGray)
                .padding(.bottom, 50)
        }
        .navigationTitle("앱 정보")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
    }
}
