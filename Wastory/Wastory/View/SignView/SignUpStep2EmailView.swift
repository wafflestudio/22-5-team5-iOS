//
//  SignUpStep2EmailView.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI

struct SignUpStep2EmailView: View {
    @State private var viewModel = SignUpStep2ViewModel()
    @State private var showRerequestEmailBox = false
    
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isCodeFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isEmailFocused = false
                        isCodeFocused = false
                        if viewModel.isCodeRequired() {
                            viewModel.touchCodeScreen()
                        }
                        else {
                            viewModel.touchEmailScreen()
                        }
                        viewModel.untapNextButton()
                    }
                
                VStack {
                    ZStack {
                        HStack {
                            Rectangle()
                                .foregroundStyle(Color.progressBarBackgroundColor)
                                .frame(width: 60, height: 5)
                                .cornerRadius(12)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        HStack {
                            Rectangle()
                                .foregroundStyle(Color.progressBarProgressColor)
                                .frame(width: 40, height: 5)
                                .cornerRadius(12)
                                .padding(.leading, 20)
                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    
                    HStack {
                        Text(viewModel.isCodeRequired() ? "이메일로 발송된" : "와스토리 계정으로 사용할")
                            .font(.system(size: 18, weight: .regular))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    .padding(.top, 24)
                    Spacer()
                        .frame(height: 5)
                    HStack {
                        Text(viewModel.isCodeRequired() ? "인증번호를 입력해 주세요." : "이메일을 입력해 주세요.")
                            .font(.system(size: 18, weight: .regular))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    if viewModel.isCodeRequired() {
                        HStack {
                            Text(viewModel.email)
                                .foregroundStyle(Color.promptLabelColor)
                                .padding(.vertical, 5)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                            .frame(height: 5)
                        Rectangle()
                            .foregroundStyle(Color.promptLabelColor)
                            .frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                    
                    ZStack {
                        if viewModel.isCodeRequired() {
                            TextField("", text: $viewModel.code, prompt: Text("인증번호 8자 입력")
                                .foregroundStyle(Color.promptLabelColor))
                            .focused($isCodeFocused)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .autocapitalization(.none)
                            .onChange(of: viewModel.code) { newValue, oldValue in
                                if oldValue.count >= viewModel.getCodeLength() {
                                    viewModel.code = String(viewModel.code.prefix(viewModel.getCodeLength()))
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isCodeFocused = true
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.clearCodeTextField()
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color.promptLabelColor)
                                }
                                .frame(width: 10, height: 10)
                                .padding(.trailing, 24)
                                .disabled(viewModel.isClearCodeButtonInactive())
                                .opacity(viewModel.isClearCodeButtonInactive() ? 0 : 1)
                            }
                        }
                        else {
                            TextField("", text: $viewModel.email, prompt: Text("이메일 입력")
                                .foregroundStyle(Color.promptLabelColor))
                            .focused($isEmailFocused)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .autocapitalization(.none)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isEmailFocused = true
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.clearEmailTextField()
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color.promptLabelColor)
                                }
                                .frame(width: 10, height: 10)
                                .padding(.trailing, 10)
                                .disabled(viewModel.isClearEmailButtonInactive())
                                .opacity(viewModel.isClearEmailButtonInactive() ? 0 : 1)
                                
                                Button {
                                    viewModel.isCodeSendingInProgress = true
                                    Task {
                                        isEmailFocused = false
                                        viewModel.touchEmailScreen()
                                        viewModel.untapNextButton()
                                        await viewModel.requestCode()
                                    }
                                } label: {
                                    Text("인증요청")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.black)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 14)
                                }
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                                )
                                .disabled(viewModel.isCodeSendingInProgress)
                                .padding(.trailing, 20)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 5)
                    
                    if viewModel.isCodeRequired() {
                        Rectangle()
                            .foregroundStyle(isCodeFocused ? .black : viewModel.codeValidator().isEmpty || !viewModel.isCodeScreenTouched() ? Color.emailCautionTextGray : Color.emptyEmailWarnRed)
                            .frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                    else {
                        Rectangle()
                            .foregroundStyle(isEmailFocused ? .black : viewModel.emailValidator().isEmpty || !viewModel.isEmailScreenTouched() ? Color.emailCautionTextGray : Color.emptyEmailWarnRed)
                            .frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                    
                    if viewModel.isCodeRequired() {
                        if !isCodeFocused && viewModel.isCodeScreenTouched() &&  !viewModel.codeValidator().isEmpty {
                            Spacer()
                                .frame(height: 5)
                            HStack {
                                Text(viewModel.codeValidator())
                                    .font(.system(size: 11, weight: .light))
                                    .foregroundStyle(Color.emptyEmailWarnRed)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    else {
                        if !isEmailFocused && viewModel.isEmailScreenTouched() && !viewModel.emailValidator().isEmpty {
                            Spacer()
                                .frame(height: 5)
                            HStack {
                                Text(viewModel.emailValidator())
                                    .font(.system(size: 11, weight: .light))
                                    .foregroundStyle(Color.emptyEmailWarnRed)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    if viewModel.isCodeRequired() == false {
                        SignUpStep2CautionText(text: "입력한 이메일로 인증번호가 발송됩니다.")
                        SignUpStep2CautionText(text: "인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.")
                        Spacer()
                            .frame(height: 24)
                    }
                    else {
                        Button {
                            showRerequestEmailBox = true
                        } label: {
                            HStack {
                                Text("인증메일을 받지 못하셨나요?")
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundStyle(.black)
                                    .underline()
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(height: 24)
                    }
                    
                    ZStack {
                        Button {
                            Task {
                                await viewModel.verifyCode()
                            }
                        } label: {
                            Text("다음")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 51)
                                .background(Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 20)
                        .disabled(!viewModel.isVerificationPossible())
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                UserInfoRepository.shared.setUserID(userID: viewModel.email)    // UserID (email) 결정
                            }
                        )
                        .opacity(viewModel.isVerificationPossible() ? 1 : 0)
                        
                        Button {
                            isEmailFocused = false
                            isCodeFocused = false
                            if viewModel.isCodeRequired() {
                                viewModel.touchCodeScreen()
                            }
                            else {
                                viewModel.touchEmailScreen()
                            }
                            viewModel.tapNextButton()
                        } label: {
                            Text("다음")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 51)
                                .background(viewModel.codeValidator().isEmpty ? Color.kakaoYellow : Color.disabledNextButtonGray)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 20)
                        .opacity(viewModel.isVerificationPossible() ? 0 : 1)
                    }
                    Spacer()
                }
                
                // MARK: - 이메일 중복 경고 창
                if viewModel.emailExists {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 240)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("이미 와스토리 계정에 사용 중인 이메일입니다.")
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 12)
                        HStack {
                            Text("등록된 와스토리 계정으로 로그인하거나, 다른 이메일을 입력해 주세요.")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.emailCautionTextGray)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 24)
                        
                        NavigationLink(destination: SignInView()) {
                            Text("로그인")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                        Spacer()
                            .frame(height: 12)
                        Button {
                            viewModel.toggleEmailExists()
                            viewModel.email = ""
                        } label: {
                            Text("다시 입력")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.disabledNextButtonGray)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                    }
                }
                
                // MARK: - 인증 코드 재전송 창
                if showRerequestEmailBox {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            // 편의 기능: 버튼 대신 배경을 터치하여도 박스 닫힘
                            showRerequestEmailBox = false
                        }
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("인증메일을 받지 못하셨나요?")
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        HStack {
                            Text("이메일이 정확한지 확인해 주세요.")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.emailCautionTextGray)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        HStack {
                            Text("메일 서비스에 따라 인증번호 발송이 늦어질 수 있습니다.")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.emailCautionTextGray)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        
                        Button {
                            viewModel.requestEmailReentry()
                            viewModel.isCodeSendingInProgress = false
                            showRerequestEmailBox = false
                        } label: {
                            HStack {
                                Text("다른 이메일로 인증")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.black)
                                    .underline()
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(height: 2)
                        
                        Button {
                            Task {
                                await viewModel.requestCode()
                                showRerequestEmailBox = false
                            }
                        } label: {
                            Text("인증번호 재발송")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                        Button {
                            showRerequestEmailBox = false
                        } label: {
                            Text("확인")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.disabledNextButtonGray)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                    }
                }
                
                // MARK: 인증 실패 창
                if viewModel.isVerificationFailed {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 150)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("입력한 인증번호가 올바르지 않습니다.")
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 24)
                        Button {
                            viewModel.isVerificationFailed.toggle()
                        } label: {
                            Text("확인")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.disabledNextButtonGray)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isVerificationSuccessful) {
                SignUpStep3PasswordView()
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

struct SignUpStep2CautionText: View {
    let text: String
    var body: some View {
        HStack(spacing: 7) {
            Circle()
                .frame(width: 2, height: 2)
            Text(text)
                .font(.system(size: 10, weight: .light))
            Spacer()
        }
        .foregroundStyle(Color.emailCautionTextGray)
        .padding(.horizontal, 20)
    }
}
