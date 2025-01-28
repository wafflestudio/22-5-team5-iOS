//
//  DropView.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import SwiftUI

struct DropView: View {
    @State private var viewModel = DropViewModel()
    @State private var showDropAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 30)
                    Text("와스토리 탈퇴 전 꼭 확인하세요")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                        .frame(height: 20)
                    
                    Text("탈퇴하시면 모든 블로그와 데이터가 파기되며")
                        .font(.system(size: 12, weight: .light))
                    Text("모든 데이터는 복구가 불가능합니다.")
                        .font(.system(size: 12, weight: .light))
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("회원 정보")
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 7)
                        HStack {
                            Text("로그인 아이디, 외부 기능 연동 정보가 삭제됩니다.")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.dropCautionBoxTextGray)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                        HStack {
                            Text("블로그 정보")
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 7)
                        HStack {
                            Text("블로그 닉네임, 모든 게시글, 댓글, 방명록, 사진 및 첨부파일, 개인 도메인 연결 정보 등이 삭제됩니다.")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.dropCautionBoxTextGray)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(
                        Rectangle()
                            .fill(Color.dropCautionBoxGray)
                            .stroke(Color.dropCautionBoxEdgeGray)
                    )
                    .padding(.horizontal, 20)
                    Spacer()
                    
                    HStack(spacing: 7) {
                        Image(systemName: viewModel.isDropAgreed ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundStyle(viewModel.isDropAgreed ? .black : Color.settingDropGray)
                        Text("모든 블로그 삭제 및 계정 데이터 삭제에 동의합니다.")
                            .font(.system(size: 12, weight: .light))
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.toggleDropAgreed()
                    }
                    .padding(.leading, 20)
                    Spacer()
                        .frame(height: 40)
                    
                    Button {
                        showDropAlert = true
                    } label: {
                        Text("탈퇴하기")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity, idealHeight: 51)
                            .background(viewModel.isDropAgreed ? .black : Color.settingItemDescGray)
                            .cornerRadius(6)
                    }
                    .disabled(viewModel.isDropAgreed == false)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                if showDropAlert {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDropAlert = false
                        }
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 160)
                        .cornerRadius(12)
                        .padding(.horizontal, 60)
                    Rectangle()
                        .foregroundStyle(Color.dropCautionBoxEdgeGray)
                        .frame(width: 1, height: 160)
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 110)
                        .cornerRadius(12)
                        .offset(y: -25)
                        .padding(.horizontal, 60)
                    Rectangle()
                        .fill(Color.dropCautionBoxEdgeGray)
                        .frame(height: 1)
                        .offset(y: 30)
                        .padding(.horizontal, 60)
                    
                    VStack(spacing: 0) {
                        Text("")    // UI 위치를 위한 더미 텍스트
                        Text("와스토리를 탈퇴하시겠습니까?")
                            .font(.system(size: 16, weight: .light))
                        Spacer()
                            .frame(height: 8)
                        Text("탈퇴 시 블로그가 폐쇄되고")
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(Color.settingDropGray)
                        Spacer()
                            .frame(height: 2)
                        Text("계정 복구도 불가합니다.")
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(Color.settingDropGray)
                        Spacer()
                            .frame(height: 40)
                        
                        HStack(spacing: 0) {
                            Button {
                                showDropAlert = false
                            } label: {
                                Text("취소")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(.black)
                            }
                            Spacer()
                                .frame(width: 110)
                            Button {
                                Task {
                                    await viewModel.deleteAccount()
                                }
                            } label: {
                                Text("탈퇴")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("탈퇴하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
    }
}

extension Color {
    static let dropCautionBoxGray: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)   // 탈퇴 경고 박스 색상
    static let dropCautionBoxEdgeGray: Color = .init(red: 221 / 255, green: 221 / 255, blue: 221 / 255)   // 탈퇴 경고 박스 모서리 색상
    static let dropCautionBoxTextGray: Color = .init(red: 100 / 255, green: 100 / 255, blue: 100 / 255)   // 탈퇴 경고 박스 문구 색상
}
