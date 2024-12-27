//
//  SignInView.swift
//  Wastory
//
//  Created by mujigae on 12/26/24.
//

import SwiftUI

struct SignInView: View {
    @State private var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("waffle")
                        .font(.system(size: 32, weight: .regular))
                        .padding(.top, 60)
                    
                    Spacer()
                        .frame(height: 60)
                    
                    ZStack {
                        TextField("", text: $viewModel.id, prompt: Text("와스토리 아이디")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.promptLabelColor))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.clearIdTextField()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.promptLabelColor)
                            }
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 30)
                            .disabled(viewModel.isClearButtonInactive())
                            .opacity(viewModel.isClearButtonInactive() ? 0 : 1)
                        }
                    }
                    
                    Divider()
                        .foregroundStyle(Color.promptLabelColor)
                        .padding(.horizontal, 20)
                    
                    ZStack {
                        SecureField("", text: $viewModel.password, prompt: Text("비밀번호")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.promptLabelColor))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .opacity(viewModel.isPasswordVisible() ? 0 : 1)
                        TextField("", text: $viewModel.password, prompt: Text("비밀번호")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.promptLabelColor))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .opacity(viewModel.isPasswordVisible() ? 1 : 0)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.togglePasswordVisibility()
                            } label: {
                                Image(systemName: viewModel.isPasswordVisible() ? "eye.slash" : "eye")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.promptLabelColor)
                            }
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 30)
                            .disabled(viewModel.isEyeButtonInactive())
                            .opacity(viewModel.isEyeButtonInactive() ? 0 : 1)
                        }
                    }
                    
                    Divider()
                        .foregroundStyle(Color.promptLabelColor)
                        .padding(.horizontal, 20)
                    
                    HStack(spacing: 8) {
                        Image(systemName: viewModel.isInfoSaveOn() ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 17))
                            .foregroundStyle(
                                viewModel.isInfoSaveOn() ? .black : Color.autoSaveLabelColor,
                                viewModel.isInfoSaveOn() ? Color.kakaoYellow : Color.autoSaveLabelColor
                            )
                        Text("간편로그인 정보 저장")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.autoSaveLabelColor)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        viewModel.toggleAutoSave()
                    }
                    
                    NavigationLink(destination: MainTabView()) {
                        Text("로그인")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity, idealHeight: 51)
                            .background(Color.kakaoYellow)
                            .cornerRadius(6)
                    }
                    .padding(.horizontal, 20)
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.login()
                    })
                    
                    Spacer()
                        .frame(height: 30)
                    
                    HStack {
                        NavigationLink(destination: SignUpView()) {
                            Text("회원가입")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(.black)
                        }
                        .padding(.leading, 20)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

extension Color {
    static let kakaoYellow: Color = .init(red: 253 / 255, green: 229 / 255, blue: 0 / 255)  // 로그인 버튼에 사용되는 카카오의 상징색
    static let promptLabelColor: Color = .init(red: 142 / 255, green: 142 / 255, blue: 142 / 255)   // 텍스트필드 프롬프트 색상
    static let autoSaveLabelColor: Color = .init(red: 102 / 255, green: 102 / 255, blue: 102 / 255)   // 간편정보 저장 문구 색상
}
