//
//  PasswordSettingView.swift
//  Wastory
//
//  Created by mujigae on 1/21/25.
//

import SwiftUI

struct PasswordSettingView: View {
    @State private var viewModel = PasswordSettingViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isPassword0Focused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isPassword2Focused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPassword0Focused = false
                        isPasswordFocused = false
                        isPassword2Focused = false
                        viewModel.isPasswordFieldTapped = true
                    }
                
                VStack {
                    Spacer()
                        .frame(height: 40)
                    HStack {
                        Text("비밀번호 변경")
                            .font(.system(size: 30, weight: .semibold))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 24)
                    HStack {
                        Text("새로 사용할 비밀번호를 등록해 주세요.")
                            .font(.system(size: 18, weight: .regular))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 40)
                    
                    // MARK: - 기존 비밀번호
                    HStack {
                        Text("기존 비밀번호")
                            .foregroundStyle(Color.emailCautionTextGray)
                            .font(.system(size: 12))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 8)
                    ZStack {
                        SecureField("", text: $viewModel.password0, prompt: Text("비밀번호 입력(8~32자리)")
                            .foregroundStyle(Color.promptLabelColor))
                        .focused($isPassword0Focused)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isPassword0Focused = true
                                viewModel.isPasswordSecureFieldRendered = true
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.clearPassword0TextField()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.promptLabelColor)
                            }
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 24)
                            .disabled(viewModel.isClearPassword0ButtonInactive())
                            .opacity(viewModel.isClearPassword0ButtonInactive() ? 0 : 1)
                        }
                    }
                    Spacer()
                        .frame(height: 5)
                    Rectangle()
                        .foregroundStyle(!viewModel.isPasswordSecureFieldRendered || isPassword0Focused ? .black : viewModel.password0Validator().isEmpty ? .emailCautionTextGray : Color.emptyEmailWarnRed)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    if viewModel.isPasswordSecureFieldRendered && !isPassword0Focused && !viewModel.password0Validator().isEmpty {
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Text(viewModel.password0Validator())
                                .font(.system(size: 11, weight: .light))
                                .foregroundStyle(Color.emptyEmailWarnRed)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 40)
                    
                    // MARK: - 새로운 비밀번호
                    HStack {
                        Text("새로운 비밀번호")
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
                        .onChange(of: isPasswordFocused) { newValue, oldValue in
                            if isPasswordFocused {
                                viewModel.isPasswordFieldTapped = true
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
                        .foregroundStyle(!viewModel.isPasswordFieldTapped || isPasswordFocused ? .black : viewModel.passwordValidator().isEmpty ? .emailCautionTextGray : Color.emptyEmailWarnRed)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 5)
                    if viewModel.isPasswordFieldTapped && !isPasswordFocused && !viewModel.passwordValidator().isEmpty {
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
                        .onChange(of: isPassword2Focused) { newValue, oldValue in
                            if isPassword2Focused {
                                viewModel.isPasswordFieldTapped = true
                            }
                        }
                        
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
                        .foregroundStyle(isPassword2Focused ? .black : !viewModel.isPasswordFieldTapped || isPasswordFocused || viewModel.isPasswordValid() ? Color.emailCautionTextGray : Color.emptyEmailWarnRed)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    if viewModel.isPasswordFieldTapped && !isPasswordFocused && !isPassword2Focused && !viewModel.isPasswordValid() {
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
                    
                    Button {
                        isPassword0Focused = false
                        isPasswordFocused = false
                        isPassword2Focused = false
                        viewModel.isPasswordFieldTapped = true
                        Task {
                            let result = await viewModel.updatePassword()
                            if result == 2 {
                                dismiss()
                            }
                            else if result == 1 {
                                viewModel.activeAlert = .samePassword
                            }
                            else {
                                viewModel.activeAlert = .wrongPassword
                            }
                        }
                    } label: {
                        Text("확인")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity, idealHeight: 51)
                            .background(viewModel.isPasswordValid() ? Color.kakaoYellow : Color.disabledNextButtonGray)
                            .cornerRadius(6)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
        .alert(item: $viewModel.activeAlert) { alertType in
            switch alertType {
            case .wrongPassword:
                return Alert(
                    title: Text("기존 비밀번호가 올바르지 않습니다."),
                    dismissButton: .cancel(Text("확인"))
                )
            case .samePassword:
                return Alert(
                    title: Text("기존 비밀번호와 새로운 비밀번호가 동일합니다."),
                    dismissButton: .cancel(Text("확인"))
                )
            }
        }
    }
}

enum PasswordSettingAlertType: Identifiable {
    case wrongPassword
    case samePassword
    
    var id: String {
        switch self {
        case .wrongPassword: return "wrongPassword"
        case .samePassword: return "samePassword"
        }
    }
}
