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
                ZStack(alignment: .top) {
                    Color.white
                        .ignoresSafeArea(.container, edges: .top)
                    
                    Color.settingDivderGray
                        .ignoresSafeArea(.container, edges: .bottom)
                    
                    Color.white
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                    
                    VStack {
                        HStack {
                            CustomBackButton(size: 24, weight: .light)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .background {
                            Rectangle()
                                .foregroundStyle(.white)
                        }
                        
                        ScrollView() {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("설정")
                                        .font(.system(size: 24, weight: .semibold))
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                Spacer()
                                    .frame(height: 30)
                                
                                SettingItem(title: "비밀번호 변경", description: UserInfoRepository.shared.checkKaKaoLogin() ? "카카오에서 비밀번호를 변경해 주세요." : UserInfoRepository.shared.getUsername(), detailView: PasswordSettingView(), disabled: UserInfoRepository.shared.checkKaKaoLogin())
                                SettingDivider(thickness: 10)
                                
                                /* 미구현으로 주석 상태로 변경
                                SettingItem(title: "알림 설정", description: "푸시 알림 상태", detailView: EmptyView())
                                SettingDivider(thickness: 10)
                                */
                                
                                SettingItem(title: "공지사항", description: "", detailView: AnnouncementView())
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "앱 정보", description: "최신 버전 사용 중", detailView: VersionView())  // TODO: 앱 정보를 관리하는 싱글톤 필요
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "이용약관", description: "", detailView: TOSView())
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "개인정보 처리방침", description: "", detailView: PrivacyPolicyView())
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "오픈소스 라이선스", description: "", detailView: OSSView())
                                SettingDivider(thickness: 10)
                                
                                SettingItem(title: "도움말", description: "", detailView: HelpView())
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "운영정책", description: "", detailView: ServicePolicyView())
                                SettingDivider(thickness: 1)
                                
                                SettingItem(title: "문의하기", description: "", detailView: ContactView())
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
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    showLogoutAlert = true
                                }
                                
                                NavigationLink(destination: DropView()) {
                                    HStack {
                                        Text("탈퇴하기")
                                            .font(.system(size: 13))
                                            .underline()
                                            .foregroundStyle(Color.settingDropGray)
                                            .padding(.bottom, 20)
                                        Spacer()
                                    }
                                    .padding(.leading, 20)
                                    .padding(.top, 25)
                                }
                            }
                        }
                    }
                }
                
                if showLogoutAlert {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showLogoutAlert = false
                        }
                    
                    VStack(spacing: 0) {
                        Text("로그아웃 하시겠습니까?")
                            .font(.system(size: 16, weight: .light))
                        Spacer()
                            .frame(height: 30)
                        
                        Rectangle()
                            .foregroundStyle(Color.dropCautionBoxEdgeGray)
                            .frame(width: 240, height: 1)
                        HStack(spacing: 40) {
                            Button {
                                showLogoutAlert = false
                            } label: {
                                Text("취소")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(.black)
                            }
                            Rectangle()
                                .foregroundStyle(Color.dropCautionBoxEdgeGray)
                                .frame(width: 1, height: 50)
                            Button {
                                viewModel.logout()
                            } label: {
                                Text("로그아웃")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .padding(.top, 30)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
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
        .background {
            Rectangle()
                .foregroundStyle(.white)
        }
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
