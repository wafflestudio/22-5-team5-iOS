//
//  SettingView.swift
//  Wastory
//
//  Created by mujigae on 1/18/25.
//

import SwiftUI

struct SettingView: View {
    @State private var viewModel = SettingViewModel()
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("설정")
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 30)
                    
                    SettingItem(title: "비밀번호 변경", description: UserInfoRepository.shared.checkKaKaoLogin() ? "카카오에서 비밀번호를 변경해 주세요." : UserInfoRepository.shared.getUsername(), detailView: PasswordSettingView(), disabled: UserInfoRepository.shared.checkKaKaoLogin())
                    SettingDivider(thickness: 10)
                    
                    SettingItem(title: "알림 설정", description: "푸시 알림 상태", detailView: EmptyView())
                    SettingDivider(thickness: 10)
                    
                    SettingItem(title: "공지사항", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "앱 정보", description: "버전 정보", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "이용약관", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "개인정보처리방침", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "오픈소스 라이선스", description: "", detailView: OSSView())
                    SettingDivider(thickness: 10)
                    
                    SettingItem(title: "도움말", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "운영정책", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    SettingItem(title: "문의하기", description: "", detailView: EmptyView())
                    SettingDivider(thickness: 1)
                    
                    HStack(spacing: 0) {
                        Text("로그아웃")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.settingItemDescGray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showLogoutAlert = true
                    }
                    
                    ZStack(alignment: .top) {
                        Color(Color.settingDivderGray)
                            .ignoresSafeArea()
                        NavigationLink(destination: DropView()) {
                            HStack {
                                Text("탈퇴하기")
                                    .font(.system(size: 13))
                                    .underline()
                                    .foregroundStyle(Color.settingDropGray)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .padding(.top, 25)
                        }
                    }
                }
                
                if showLogoutAlert {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showLogoutAlert = false
                        }
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 120)
                        .cornerRadius(12)
                        .padding(.horizontal, 60)
                    Rectangle()
                        .foregroundStyle(Color.dropCautionBoxEdgeGray)
                        .frame(width: 1, height: 120)
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 80)
                        .cornerRadius(12)
                        .offset(y: -20)
                        .padding(.horizontal, 60)
                    Rectangle()
                        .fill(Color.dropCautionBoxEdgeGray)
                        .frame(height: 1)
                        .offset(y: 20)
                        .padding(.horizontal, 60)
                    
                    Text("로그아웃 하시겠습니까?")
                        .font(.system(size: 16, weight: .light))
                        .offset(y: -18)
                    
                    HStack(spacing: 0) {
                        Button {
                            showLogoutAlert = false
                        } label: {
                            Text("취소")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                            .frame(width: 95)
                        Button {
                            viewModel.logout()
                        } label: {
                            Text("로그아웃")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(.red)
                        }
                    }
                    .offset(x: 7)
                    .offset(y: 40)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
    }
}

struct SettingItem<DetailView: View>: View {
    let title: String
    let description: String
    let detailView: DetailView
    var disabled: Bool = false
    
    var body: some View {
        NavigationLink(destination: detailView) {
            HStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(disabled ? Color.settingItemDescGray : .black)
                Spacer()
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(disabled ? Color.settingDisabledBlue : Color.settingItemDescGray)
                Spacer()
                    .frame(width: 20)
                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.settingItemDescGray)
            }
        }
        .disabled(disabled)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct SettingDivider: View {
    let thickness: CGFloat
    var body: some View {
        Rectangle()
            .frame(height: thickness)
            .foregroundStyle(Color.settingDivderGray)
    }
}

extension Color {
    static let settingItemDescGray: Color = .init(red: 187 / 255, green: 187 / 255, blue: 187 / 255)   // 설정 목록 세부 정보 색상
    static let settingDivderGray: Color = .init(red: 247 / 255, green: 247 / 255, blue: 247 / 255)   // 설정 분리선 색상
    static let settingDropGray: Color = .init(red: 144 / 255, green: 144 / 255, blue: 144 / 255)   // 탈퇴하기 문구 색상
    static let settingDisabledBlue: Color = .init(red: 108 / 255, green: 192 / 255, blue: 255 / 255)   // 불가능 항목 알림 색상 (불쾌감을 주지 않기 위해 청색을 채택)
}
