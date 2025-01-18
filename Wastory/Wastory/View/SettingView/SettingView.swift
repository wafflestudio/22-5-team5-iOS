//
//  SettingView.swift
//  Wastory
//
//  Created by mujigae on 1/18/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        Text("설정")
            .font(.system(size: 24, weight: .semibold))
        SettingItem(title: "대표 블로그 설정", description: UserInfoRepository.shared.getUsername(), detailView: EmptyView())
    SettingItem(title: "알림 설정", description: "푸시 알림 상태", detailView: EmptyView())
    SettingItem(title: "공지사항", description: "", detailView: EmptyView())
    SettingItem(title: "앱 정보", description: "버전 정보", detailView: EmptyView())
    SettingItem(title: "이용약관", description: "", detailView: EmptyView())
    SettingItem(title: "개인정보처리방침", description: "", detailView: EmptyView())
    SettingItem(title: "오픈소스 라이선스", description: "", detailView: EmptyView())
    SettingItem(title: "도움말", description: "", detailView: EmptyView())
    SettingItem(title: "운영정책", description: "", detailView: EmptyView())
    SettingItem(title: "문의하기", description: "", detailView: EmptyView())
    SettingItem(title: "로그아웃", description: "", detailView: EmptyView())
    }
}

struct SettingItem<DetailView: View>: View {
    let title: String
    let description: String
    let detailView: DetailView
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
            Text(description)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.settingItemDescGray)
            NavigationStack {
                NavigationLink(destination: detailView) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.settingItemDescGray)
                }
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

extension Color {
    static let settingItemDescGray: Color = .init(red: 187 / 255, green: 187 / 255, blue: 187 / 255)   // 설정 목록 세부 정보 색상
}

#Preview {
    SettingView()
}
