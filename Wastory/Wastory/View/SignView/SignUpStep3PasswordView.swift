//
//  SignUpStep3PasswordView.swift
//  Wastory
//
//  Created by mujigae on 1/2/25.
//

import SwiftUI

struct SignUpStep3PasswordView: View {
    @State private var viewModel = SignUpStep3ViewModel()
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isPassword2Focused: Bool
    @State private var isPasswordSecureFieldRendered: Bool = false

    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .foregroundStyle(Color.progressBarProgressColor)
                    .frame(width: 60, height: 5)
                    .cornerRadius(12)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 20)
            
            HStack {
                Text("와스토리 계정 로그인에 사용할")
                    .font(.system(size: 18, weight: .regular))
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.top, 24)
            Spacer()
                .frame(height: 5)
            HStack {
                Text("비밀번호를 등록해 주세요.")
                    .font(.system(size: 18, weight: .regular))
                    .padding(.horizontal, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("와스토리 계정")
                    .foregroundStyle(Color.emailCautionTextGray)
                    .font(.system(size: 12))
                    .padding(.horizontal, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 8)
            HStack {
                Text(UserInfoRepository.shared.getUserID())
                    .foregroundStyle(.black)
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.horizontal, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("비밀번호")
                    .foregroundStyle(Color.emailCautionTextGray)
                    .font(.system(size: 12))
                    .padding(.horizontal, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 8)
            ZStack {
                SecureField("", text: $viewModel.password, prompt: Text("비밀번호 입력(8~32자리)")
                    .foregroundStyle(Color.promptLabelColor))
                .focused($isPasswordFocused)
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isPasswordFocused = true
                        isPasswordSecureFieldRendered = true
                    }
                }
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.clearPasswordTextField()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.promptLabelColor)
                    }
                    .frame(width: 10, height: 10)
                    .padding(.trailing, 24)
                    .disabled(viewModel.isClearPasswordButtonInactive())
                    .opacity(viewModel.isClearPasswordButtonInactive() ? 0 : 1)
                }
            }
            Spacer()
                .frame(height: 5)
            Rectangle()
                .foregroundStyle(!isPasswordSecureFieldRendered || isPasswordFocused ? .black : viewModel.passwordValidator().isEmpty ? .emailCautionTextGray : Color.emptyEmailWarnRed)
                .frame(height: 1)
                .padding(.horizontal, 20)
            Spacer()
                .frame(height: 5)
            if isPasswordSecureFieldRendered && !isPasswordFocused && !viewModel.passwordValidator().isEmpty {
                Spacer()
                    .frame(height: 5)
                HStack {
                    Text(viewModel.passwordValidator())
                        .font(.system(size: 11, weight: .light))
                        .foregroundStyle(Color.emptyEmailWarnRed)
                        .padding(.horizontal, 20)
                    Spacer()
                }
            }
            
            ZStack {
                SecureField("", text: $viewModel.password2, prompt: Text("비밀번호 재입력")
                    .foregroundStyle(Color.promptLabelColor))
                .focused($isPassword2Focused)
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.clearPassword2TextField()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.promptLabelColor)
                    }
                    .frame(width: 10, height: 10)
                    .padding(.trailing, 24)
                    .disabled(viewModel.isClearPassword2ButtonInactive())
                    .opacity(viewModel.isClearPassword2ButtonInactive() ? 0 : 1)
                }
            }
            Spacer()
                .frame(height: 5)
            Rectangle()
                .foregroundStyle(isPassword2Focused ? .black : isPasswordFocused || viewModel.isEqualPassword() ? Color.emailCautionTextGray : Color.emptyEmailWarnRed)
                .frame(height: 1)
                .padding(.horizontal, 20)
            if !isPasswordFocused && !isPassword2Focused && !viewModel.isEqualPassword() {
                Spacer()
                    .frame(height: 5)
                HStack {
                    Text("입력한 비밀번호와 재입력한 비밀번호가 일치하지 않습니다.")
                        .font(.system(size: 11, weight: .light))
                        .foregroundStyle(Color.emptyEmailWarnRed)
                        .padding(.horizontal, 20)
                    Spacer()
                }
            }
            Spacer()
                .frame(height: 24)
            
            SignUpStep2CautionText(text: "비밀번호는 8~32자리의 영문 대소문자, 숫자, 특수문자를 조합하여 설정해 주세요.")
            SignUpStep2CautionText(text: "다른 사이트에서 사용하는 것과 동일하거나 쉬운 비밀번호는 사용하지 마세요")
            SignUpStep2CautionText(text: "안전한 계정 사용을 위해 비밀번호는 주기적으로 변경해 주세요.")
            Spacer()
                .frame(height: 24)
            
            ZStack {
                NavigationLink(destination: SignUpStep4WelcomeView()) {
                    Text("다음")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(Color.kakaoYellow)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .disabled(!viewModel.isEqualPassword())
                .opacity(viewModel.isEqualPassword() ? 1 : 0)
                
                Button {
                } label: {
                    Text("다음")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background( Color.disabledNextButtonGray)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .opacity(viewModel.isEqualPassword() ? 0 : 1)
            }
            
            Spacer()
        }
        .onTapGesture {
            isPasswordFocused = false
            isPassword2Focused = false
        }
    }
}
